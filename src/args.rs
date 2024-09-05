use clap::{
    Parser,
    Args,
    Subcommand
};

#[derive(Debug, Parser)]
#[clap(author = "Ilyas Khallouki", version = "0.1.0", about = "A simple VM management tool")]
pub struct QvirtArgs {
    #[clap(subcommand)]
    command: Commands
}

#[derive(Debug, Subcommand)]
pub enum Commands {
    /// create VM
    Create (CreateCommand)
}

#[derive(Debug, Args)]
pub struct  CreateCommand {
    /// name of the VM to create
    pub name: String,
    /// Memory to be used
    pub memory: Option<u32>
}