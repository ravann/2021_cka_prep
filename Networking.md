## Peer-to-peer networking

### Create virtual nic

ip netns add red
ip netns add blue

### Check the nic

ip link
ip netns exec red ip link

arp
ip netns exec red arp

### Create a virtual ethernet cable

ip link add veth-red type veth peer name veth-blue

### Attach the cable to the nics

ip link set veth-red netns red
ip link set veth-blue netns blue

### Add IP address

ip netns exec red ip addr add 192.168.15.1/24 dev veth-red
ip netns exec blue ip addr add 192.168.15.2/24 dev veth-blue

### Bring up the interface

ip -n red link set veth-red up
ip -n blue link set veth-blue up

### Check ping works

ip netns exec red ping 192.168.15.2
ip netns exec red ping 192.168.15.1

### ARP table is now populated

ip netns exec red arp

## Creating the bridge - didnt work :(

### Create virtual nic

ip netns add red
ip netns add blue

### Create the bridge and bring it up

ip link add v-net-0 type bridge
ip link set v-net-0 up

### Create virtual cables

ip link add veth-red type veth peer name veth-red-br
ip link add veth-blue type veth peer name veth-blue-br

### Attach cables to nics

#### red cable must connect to red nic and bridge; blue cable must connect to blue nic and bridge

ip link set veth-red netns red
ip link set veth-red-br master v-net-0

ip link set veth-blue netns blue
ip link set veth-blue-br master v-net-0

### Add IP address

ip netns exec red ip addr add 192.168.15.1/24 dev veth-red
ip netns exec blue ip addr add 192.168.15.2/24 dev veth-blue

ip addr add 192.168.15.5/24 dev v-net-0
