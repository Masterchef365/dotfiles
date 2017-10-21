use config::Rgb;
pub fn color_fmt(prefix: char, color: Rgb) -> String {
    format!("%{{{}#{}}}", prefix, color.to_hex())
}
