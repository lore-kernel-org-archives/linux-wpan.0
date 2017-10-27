Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:20031 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752411AbdJ0KTQ (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Fri, 27 Oct 2017 06:19:16 -0400
Message-ID: <1509099550.18015.13.camel@linux.intel.com>
Subject: Re: [RFC 3/3] tun: Add 6LoWPAN compression/decompression to tun
 driver
From: Patrik Flykt <patrik.flykt@linux.intel.com>
Date: Fri, 27 Oct 2017 13:19:10 +0300
In-Reply-To: <CAOHTApijss4n7r6tr7oMdGGduzVs-Hx=s0r5uL4+ACX1d=ePFw@mail.gmail.com>
References: <20171018120615.24126-3-patrik.flykt@linux.intel.com>
         <20171018120615.24126-4-patrik.flykt@linux.intel.com>
         <20171018122705.25478-1-patrik.flykt@linux.intel.com>
         <CAOHTApijss4n7r6tr7oMdGGduzVs-Hx=s0r5uL4+ACX1d=ePFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan - ML <linux-wpan@vger.kernel.org>, luiz.von.dentz@intel.com, Jamal Hadi Salim <hadi@mojatatu.com>, Stefan Schmidt <stefan@osg.samsung.com>, mcr@sandelman.ca


	Hi Alex,

On Thu, 2017-10-26 at 10:54 -0400, Alexander Aring wrote:
> LOWPAN_IPHC_MAX_HC_BUF_LEN more bytes are added to sk_buff headroom
> > to ensure there will be enough bytes to push headers to. This is
> > probably an overkill and probably done wrongly anyway.
> > 
> 
> This define should be removed because there exists no case where the
> compression will be larger than the ipv6 header and vice versa.

Ok, good to know. I could not convince myself otherwise, so I took a
shot at it with a really big cannon. I will remove this from any future
iterations.

> > An ethernet MAC header is added in front of the (compressed) IPv6
> > datagram in both directions; no such transport exists for 6LoWPAN,
> > but this is just an example implementation trying to explain the
> > idea behind the BTLE handling in user space and the 6LoWPAN
> > compression and decompression in kernel space. Thus the tun/tap
> > driver comes in handy as the victim of the demonstration.
> 
> Sorry but this really scares me.

The header format should of course take 802.15.4 and Bluetooth into
account, but for the time being this was the easiest wrt time that I
could implement and simplest to understand. See 
https://marc.info/?l=linux-wpan&m=150849496308755&w=2 how it is all
used together in Luiz' patch set.

Do we have a user space entity for 802.15.4 similar to Bluez that needs
to do the same thing? If yes, the different address lengths will then
mandate a new header format to be used that fits both technologies and
8, 6 and 2 byte MAC addresses.

> The kernel use 6LoWPAN IPHC for
> ethernet (as mac header information) and you doing BTLE/L2CAP stuff
> in user space which is not anymore for your original use-case which
> is "ethernet".

It's actually the other way round. BTLE/IPSP requires 6LoWPAN
copmression in RFC 7668. Those BTLE/IPSP encapsulated 6LoWPAN
compressed IPv6 packets need to end up somewhere, and as Bluetooth uses
otherwise "ethernet compatible" MAC addresses, it's really easy to
write an ethernet header in front and have the rest of the Linux kernel
to forward it, be it via a bridge or plain IP routing.

> This might work for now, because only address handling is used in
> IPHC as MAC header information and eth/btle use the same address
> length (besides that the address is not always the same and BTLE is
> not a EUI-48 address with multicast bit etc.)

Yes, the address generation is different from 802.15.4, see RFC 7668,
Section 3.2.2.

> You cannot simple use MAC X handling in kernelspace and use then MAC
> handling Y in userspace - this will not work for long time.

Sending ethernet frames stuffed with 6LoWPAN is not a generally good
idea, its just easy for demonstration purposes. As above, a new header
format of expressing MAC addresses is probably the way to go?

> I already
> fight with UDP based protocols in 802.15.4 6LoWPAN who depends on
> 802.15.4 MAC information which are not just addressing information. 

Quickly looking into UDP header compression didn't reveal any further
dependencies on MAC addressing, which specification did you have in
mind wrt UDP or similar layer headers?
 
> If they need more bluetooth related information there you have no
> possibility to get them. The same for next header compression which
> might want more MAC information than just addressing for bluetooth.

There are no additional dependencies or even planned ones from 6LoWPAN
to Bluetooth that I'm aware of. So I'd go with the assumption that
6LoWPAN will know only of the MAC addresses and the (MAC layer) data
length, with the rest of the information being on IP(v6) level.

> > +                       if (lowpan_header_decompress(skb, &tun-
> > >ldev,
> > +                                                       tun->dev-
> > >dev_addr,
> > +                                                       &eth.h_sour
> > ce) < 0) {
> 
> This will make a module dependency of 6lowpan_iphc for the tap
> driver. I am pretty sure that the tap driver people doesn't like
> that.

Ok, needs to be adressed.

> Which
> brings me to another issue with this patch:
> Why you don't create a virtual lowpan interface on top of the tap
> device. This handling is _incredibly_ against our design to have a
> 6LoWPAN interface device type for the user space.
> Now we have will have a tap device which makes internally 6LoWPAN
> handling but is not visible as 6LoWPAN interface in the user space,
> this will confuse 6LoWPAN user space applications.

The only user space application that will know of 6LoWPAN compression
being applied is Bluez. There are zero parameters that can be tuned, as
Bluetooth specifies no configurable knobs for the 6LoWPAN IPv6
datagrams that are transported over BTLE/IPSP. The Bluetooth
specification relies on RFC 7668 getting the IPv6 details in sync end
to end.

What, if any, user space application would be able to manipulate a
Bluetooth 6LoWPAN interface and why? Much like a VPN with compression,
Bluetooth is by its nature tunneling 6LoWPAN IPv6 over BTLE/IPSP so
there is no inherent need of a device driver specific for handling
6LoWPAN.

> What our design is (just to remember):
>  - Ethernet interface (MAC/6LoWPAN view, before adaption)
>  - 6LoWPAN interface (IPv6 view, after adaption)
> 
> I am pretty sure you can run your above changes transparently
> separated of TAP driver by adding a 6LoWPAN interface on top. This
> will also make no dependency to the TAP driver.

Probably. But that also means there is some other user space
application that can somehow manipulate such an interface. But for
Bluetooth there already is Bluez that takes care of setting up and
tearing down connections, si there isn't much need of any other
application to control or configure BTLE/IPSP interfaces?

> I guess what you want is a TAP interface which is NOT ethernet. It
> need to get some special MAC information for your subsystem which is
> BTLE. Not using ethernet here. To have the assumption here "it will
> work because the address length is the same" is simple wrong, they
> will be more use-cases where upper-layers need to have special MAC
> information belongs to your link-layer subsystem.

So it does sound like we do want a decent header for 6LowPAN traffic
which can take both 802.15.4 and Bluetooth systems into account when
dealing with the TAP file descriptor pulling the packets to/from user
space, right? The end result in the kernel should be ethernet MAC
frames for Bluetooth for maximum compatibility with all other
networking subsystems, and with 802.15.4 frames for IEEE 802.15.4?


Cheers,

	Patrik
