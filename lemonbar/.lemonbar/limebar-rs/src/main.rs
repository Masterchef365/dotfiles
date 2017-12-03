extern crate systemstat;
use systemstat::{System, Platform};

extern crate i3ipc;

extern crate mpd;

#[macro_use]
extern crate serde_derive;
extern crate serde;
extern crate serde_yaml;
extern crate chrono;

use i3ipc::Subscription;
use i3ipc::I3Connection;
use i3ipc::I3EventListener;

use chrono::Local;

use std::path::Path;

mod config;
use config::Config;

mod lemonbar;
use lemonbar::*;

use std::sync::mpsc::*;

use mpd::{Client, Idle, Subsystem, State};
use std::net::TcpStream;

enum Update {
    Clock(String),
    Battery(String),
    I3(String),
    Mpd(String),
}

fn i3(background_high: String, background_def: String, foreground: String, tx: Sender<Update>) {
    std::thread::spawn(move || {
        let mut listner = I3EventListener::connect().unwrap();
        listner.subscribe(&[Subscription::Workspace]).unwrap();
        let mut connection = I3Connection::connect().unwrap();
        loop {
            let mut format_workspaces = || {
                let mut out = String::new();
                out.clear();
                let workspaces = connection.get_workspaces().unwrap().workspaces;
                out.push_str(&foreground);
                for workspace in workspaces {
                    if workspace.focused {
                        out.push_str(&background_high);
                    } else {
                        out.push_str(&background_def);
                    }
                    out.push_str(&format!(" {} ", workspace.name));
                }
                tx.send(Update::I3(out)).expect(
                    "Clock failed to send data!",
                );
            };

            format_workspaces();
            for _ in listner.listen() {
                format_workspaces();
            }
        }
    });
}

fn battery(background: String, foreground: String, tx: Sender<Update>) {
    let sys = System::new();
    std::thread::spawn(move || loop {
        tx.send(Update::Battery(format!(
            "{}{} {} ",
            background,
            foreground,
            if let Ok(battery_input) = sys.battery_life() {
                format!("{}%", (battery_input.remaining_capacity * 100.0) as i32)
            } else {
                format!("No battery...?")
            }
        ))).expect("Clock failed to send data!");
        std::thread::sleep(std::time::Duration::from_secs(20));
    });
}

fn clock(background: String, foreground: String, tx: Sender<Update>) {
    std::thread::spawn(move || loop {
        tx.send(Update::Clock(format!(
            "{}{}{} ",
            background,
            foreground,
            Local::now().format(" %a %D %H:%M")
        ))).expect("Clock failed to send data!");
        std::thread::sleep(std::time::Duration::from_secs(60));
    });
}

fn mpd(background_def: String, background_high: String, foreground: String, tx: Sender<Update>) {
    let mut c = Client::new(TcpStream::connect("127.0.0.1:6600").unwrap()).unwrap();
    std::thread::spawn(move || loop {
        if c.queue().is_ok() && c.status().is_ok() && c.status().unwrap().song.is_some() &&
            c.status().unwrap().state == State::Play
        {
            let song = c.queue().unwrap()[c.status().unwrap().song.unwrap().pos as usize].clone();
            let mut display: String =
                format!(
                " {}{} ",
                if let Some(artist) = song.tags.get("Artist") {
                    format!("{} - ", artist)
                } else {
                    format!("")
                },
                song.title.unwrap_or(song.name.unwrap_or(song.file)),
            );
            let elapsed = c.status().unwrap().elapsed.unwrap().num_seconds();
            let duration = c.status().unwrap().duration.unwrap().num_seconds();
            let idx = (((elapsed as f32) / (duration as f32)) * (display.len() as f32)) as usize;
            display.insert_str(idx, &background_def);
            tx.send(Update::Mpd(
                format!("{}{}{}", background_high, foreground, display),
            )).expect("Clock failed to send data!");
        } else {
            tx.send(Update::Mpd(format!("")));
        }
        c.wait(
            &[
                Subsystem::Database,
                Subsystem::Update,
                Subsystem::Playlist,
                Subsystem::Queue,
                Subsystem::Player,
                Subsystem::Mixer,
                Subsystem::Output,
                Subsystem::Options,
                Subsystem::Sticker,
                Subsystem::Subscription,
                Subsystem::Message,
            ],
        );
    });
}

fn main() {
    let arg = std::env::args().last().expect("No config file input!");
    let path = Path::new(&arg);
    let palette = Config::load_file(path).colors;
    let (tx, rx) = channel();

    i3(
        color_fmt('B', palette.bright.blue),
        color_fmt('B', palette.bright.red),
        color_fmt('F', palette.primary.foreground),
        tx.clone(),
    );

    clock(
        color_fmt('B', palette.bright.red),
        color_fmt('F', palette.primary.foreground),
        tx.clone(),
    );
    battery(
        color_fmt('B', palette.bright.red),
        color_fmt('F', palette.primary.foreground),
        tx.clone(),
    );

    /*
       mpd(
       color_fmt('B', palette.bright.black),
       color_fmt('B', palette.bright.blue),
       color_fmt('F', palette.primary.foreground),
       tx.clone(),
       );
       */

    let mut clock_string = String::new();
    let mut i3_string = String::new();
    let mut mpd_string = String::new();
    let mut battery_string = String::new();
    loop {
        for update in rx.recv() {
            match update {
                Update::Clock(out) => clock_string = out,
                Update::I3(out) => i3_string = out,
                Update::Mpd(out) => mpd_string = out,
                Update::Battery(out) => battery_string = out,
            }
            println!(
                "{}%{{r}}{}{} {}{}",
                i3_string,
                battery_string,
                color_fmt('B', palette.primary.background),
                clock_string,
                color_fmt('B', palette.primary.background)
            );
        }
    }

}
