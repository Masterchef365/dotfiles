extern crate i3ipc;

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

/*
enum Update<'a> {
    Clock(&'a str),
    I3(&'a str),
}
*/
enum Update {
    Clock(String),
    I3(String),
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

fn main() {
    let arg = std::env::args().last().expect("Not enough args!");
    let path = Path::new(&arg);
    let palette = Config::load_file(path).colors;
    let (tx, rx) = channel();

    i3(
        color_fmt('B', palette.bright.blue),
        color_fmt('B', palette.bright.black),
        color_fmt('F', palette.primary.foreground),
        tx.clone(),
    );

    clock(
        color_fmt('B', palette.bright.black),
        color_fmt('F', palette.primary.foreground),
        tx.clone(),
    );

    let mut clock_string = String::new();
    let mut i3_string = String::new();
    loop {
        for update in rx.recv() {
            match update {
                Update::Clock(out) => clock_string = out,
                Update::I3(out) => i3_string = out,
            }
            println!(
                "{}%{{r}}{}{}",
                i3_string,
                clock_string,
                color_fmt('B', palette.primary.background)
            );
        }
    }

}
