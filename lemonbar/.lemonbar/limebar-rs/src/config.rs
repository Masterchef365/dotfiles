use std::fmt;
use std::str::FromStr;
use serde_yaml;
use serde::de;
use serde::de::Visitor;
use std::path::Path;
use std::fs::File;

/// Top-level config type
#[derive(Debug, Deserialize)]
pub struct Config {
    pub colors: Colors,
}

impl Config {
    pub fn load_file(path: &Path) -> Self {
        serde_yaml::from_reader(File::open(path).expect("Failed open config file!"))
            .expect("Failed to parse config file")
    }
}

#[derive(Debug, Deserialize)]
pub struct Colors {
    pub primary: PrimaryColors,
    pub normal: AnsiColors,
    pub bright: AnsiColors,
}

#[derive(Debug, Deserialize)]
pub struct PrimaryColors {
    #[serde(deserialize_with = "rgb_from_hex")]
    pub background: Rgb,
    #[serde(deserialize_with = "rgb_from_hex")]
    pub foreground: Rgb,
}

/// The 8-colors sections of config
#[derive(Debug, Deserialize)]
pub struct AnsiColors {
    #[serde(deserialize_with = "rgb_from_hex")]
    pub black: Rgb,
    #[serde(deserialize_with = "rgb_from_hex")]
    pub red: Rgb,
    #[serde(deserialize_with = "rgb_from_hex")]
    pub green: Rgb,
    #[serde(deserialize_with = "rgb_from_hex")]
    pub yellow: Rgb,
    #[serde(deserialize_with = "rgb_from_hex")]
    pub blue: Rgb,
    #[serde(deserialize_with = "rgb_from_hex")]
    pub magenta: Rgb,
    #[serde(deserialize_with = "rgb_from_hex")]
    pub cyan: Rgb,
    #[serde(deserialize_with = "rgb_from_hex")]
    pub white: Rgb,
}

/// Deserialize an Rgb from a hex string
///
/// This is *not* the deserialize impl for Rgb since we want a symmetric
/// serialize/deserialize impl for ref tests.
fn rgb_from_hex<'a, D>(deserializer: D) -> ::std::result::Result<Rgb, D::Error>
where
    D: de::Deserializer<'a>,
{
    struct RgbVisitor;

    impl<'a> Visitor<'a> for RgbVisitor {
        type Value = Rgb;

        fn expecting(&self, f: &mut fmt::Formatter) -> fmt::Result {
            f.write_str("Hex colors spec like 'ffaabb'")
        }

        fn visit_str<E>(self, value: &str) -> ::std::result::Result<Rgb, E>
        where
            E: ::serde::de::Error,
        {
            Rgb::from_str(&value[..]).map_err(|_| E::custom("failed to parse rgb; expect 0xrrggbb"))
        }
    }

    deserializer.deserialize_str(RgbVisitor)
}

#[derive(Debug, Clone, Deserialize, Default, Copy)]
pub struct Rgb {
    pub r: u8,
    pub g: u8,
    pub b: u8,
}

impl Rgb {
    pub fn to_hex(&self) -> String {
        format!("{:02x}{:02x}{:02x}", self.r, self.g, self.b)
    }
}

impl FromStr for Rgb {
    type Err = ();
    fn from_str(s: &str) -> ::std::result::Result<Rgb, ()> {
        let mut chars = s.chars();
        let mut rgb = Rgb::default();

        macro_rules! component {
            ($($c:ident),*) => {
                $(
                    match chars.next().unwrap().to_digit(16) {
                        Some(val) => rgb.$c = (val as u8) << 4,
                        None => return Err(())
                    }

                    match chars.next().unwrap().to_digit(16) {
                        Some(val) => rgb.$c |= val as u8,
                        None => return Err(())
                    }
                )*
            }
        }

        match chars.next().unwrap() {
            '0' => {
                if chars.next().unwrap() != 'x' {
                    return Err(());
                }
            }
            '#' => (),
            _ => return Err(()),
        }

        component!(r, g, b);

        Ok(rgb)
    }
}
