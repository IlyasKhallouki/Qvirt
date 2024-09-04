use clap::{Parser, Subcommand};

#[derive(Parser)]
#[command(author = "Ilyas Khallouki", version = "0.1.0", about = "A simple VM management tool")]
struct Cli {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand)]
enum Commands {
    Create {
        name: String,
        memory: Option<u64>,
        vcpu: Option<u32>,
        iso_path: Option<String>,
        storage_size: Option<u64>,
    },
    Start {
        name: String,
    },
    List,
    Remove {
        name: String,
    },
}

fn main() {
    let cli = Cli::parse();

    match cli.command {
        Commands::Create {
            name,
            memory,
            vcpu,
            iso_path,
            storage_size,
        } => {
            println!("Creating VM with name: {}", name);
            // TODO: Implement actual VM creation logic using libvirt
        }
        Commands::Start { name } => {
            println!("Starting VM: {}", name);
            // TODO: Implement actual VM start logic using libvirt
        }
        Commands::List => {
            println!("Listing VMs");
            // TODO: Implement actual VM listing logic using libvirt
        }
        Commands::Remove { name } => {
            println!("Removing VM: {}", name);
            // TODO: Implement actual VM removal logic using libvirt
        }
    }
}
