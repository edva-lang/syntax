//! Network packet processor and connection state manager.

use std::collections::HashMap;
use std::net::SocketAddr;
use std::sync::Arc;

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum PacketKind {
    Handshake { version: u32 },
    Payload(Vec<u8>),
    Ping(u64),
    Disconnect,
}

pub struct PeerConnection {
    pub addr: SocketAddr,
    pub bytes_sent: u64,
    pub is_authenticated: bool,
}

impl PeerConnection {
    pub fn new(addr: SocketAddr) -> Self {
        Self {
            addr,
            bytes_sent: 0,
            is_authenticated: false,
        }
    }

    pub fn handle_packet(&mut self, packet: &PacketKind) -> Result<usize, &'static str> {
        match packet {
            PacketKind::Handshake { version } if *version >= 2 => {
                self.is_authenticated = true;
                Ok(0)
            }
            PacketKind::Payload(bytes) if self.is_authenticated => {
                self.bytes_sent += bytes.len() as u64;
                Ok(bytes.len())
            }
            PacketKind::Ping(_) => Ok(8),
            PacketKind::Disconnect => {
                self.is_authenticated = false;
                Ok(0)
            }
            _ => Err("Invalid packet state"),
        }
    }
}
