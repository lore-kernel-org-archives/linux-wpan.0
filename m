Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:33333 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848AbbATToO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 20 Jan 2015 14:44:14 -0500
Received: by mail-we0-f174.google.com with SMTP id x3so6569606wes.5
        for <linux-wpan@vger.kernel.org>; Tue, 20 Jan 2015 11:44:13 -0800 (PST)
Date: Tue, 20 Jan 2015 20:44:10 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Device or resource busy
Message-ID: <20150120194407.GB18226@omega>
References: <CAAkG1NOO3ScSHG7x+LgU6Min8OP-vcihwXwmLH7JSzGeVw8tyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAkG1NOO3ScSHG7x+LgU6Min8OP-vcihwXwmLH7JSzGeVw8tyQ@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Rohit Kulkarni <rmkulkar@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Tue, Jan 20, 2015 at 05:58:45PM +0530, Rohit Kulkarni wrote:
> Hi,
> 
> When trying to set the pan_id for a node, I keep getting device or
> resource busy. the "ifdown wpan1" says "interface wpan1 not
> configured". "ifconfig wpan1 down" doesn't throw an error but it seems
> to be a no-op.  (wpan0 is the fake radio interface and wpan1 is the
> at86rf212b module. Also, the error's the same for the wpan0
> interface). There was an email on the list about a month ago with the
> same problem. Have there been any updates on the issue?
> 

I can't reproduce the issue with the -EBUSY error. This should be fixed
by a ifdown of the interface before.

I don't know where the printout "interface wpan1 not configured" comes
from.

For doing a ifdown:

I use "ip" rather than "ifconfig". I will show some example: at beginning
we have a wpan0 interface which is down:

`ip link show wpan0`:

2: wpan0: <BROADCAST,NOARP> mtu 127 qdisc fq_codel state DOWN mode DEFAULT group default qlen 1000
    link/ieee802.15.4 94:8a:f5:4c:b3:b6:da:ff brd ff:ff:ff:ff:ff:ff:ff:ff

after calling `ip link set wpan0 up` we have:

2: wpan0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 127 qdisc fq_codel state UNKNOWN mode DEFAULT group default qlen 1000
    link/ieee802.15.4 94:8a:f5:4c:b3:b6:da:ff brd ff:ff:ff:ff:ff:ff:ff:ff

Notice the netdev flag changes to "UP". Please check that on your side.

The fakelb driver:

Also I would not use the fake driver, there is a huge TODO list on my side
for this driver. When I used this driver the first time, I detected
that the driver received the frames which actual the driver actual sending,
Which is wrong.

Additional the fakelb driver makes no sense with only one fake registered
phy. We need to update the whole driver and documentation. I would mark this
driver as broken.

> I'm using the tip of the bluetooth-next kernel and the release tarball
> for wpan-tools-0.3 on a raspberry pi attached to an at86rf212b module
> over spi. Please let me know if I missed out on any relevant info.
> 
> Also, when I try to create a coordinator node, I get an "invalid
> argument" error. I've added the netlink debug messages from this at
> the bottom. Once, I can pair a node and a coordinator, I'd like to
> send/receive messages between them from userland code (even broadcast
> messages will do for now!). Is it too optimistic yet? Or has it been
> done already? If it is already supported, even the simplest of code
> samples will save me a lot of time! :)
> 

Sorry, coordinator support isn't available yet. But you could use a node
interface and sending via RAW socket interface. Furthermore the should be a
coordinator interface and some netlink commands do to such MLME ops...
then handling with coordinators would be easily. There exists also no MLME
ops for node interfaces, so you need to do the pan association full
inside userspace via RAW sockets.

Currently, we handling dataframes via DGRAM and 6LoWPAN only.

- Alex
