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
    /// Create a new virtual machine (VM)
    Create(CreateCommand)
}

#[derive(Debug, Args)]
pub struct CreateCommand {
    /// Name of the virtual machine to be created
    pub name: String,
    /// Path to the ISO image to use for the VM
    #[clap(default_value = "resources/distors/tinycore.iso")]
    pub img: Option<String>,
    /// Amount of memory to allocate for the VM in megabytes
    #[clap(default_value = "1024")]
    pub memory: Option<u32>,
    /// Amount of storage space to allocate for the VM in megabytes
    #[clap(default_value = "5120")]
    pub storage: Option<u32>
}
