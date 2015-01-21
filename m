Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:59748 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbbAUKaE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 21 Jan 2015 05:30:04 -0500
Received: by mail-wg0-f41.google.com with SMTP id a1so16867314wgh.0
        for <linux-wpan@vger.kernel.org>; Wed, 21 Jan 2015 02:30:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20150120194407.GB18226@omega>
References: <CAAkG1NOO3ScSHG7x+LgU6Min8OP-vcihwXwmLH7JSzGeVw8tyQ@mail.gmail.com>
	<20150120194407.GB18226@omega>
Date: Wed, 21 Jan 2015 16:00:03 +0530
Message-ID: <CAAkG1NNuA0vp1A6brVbHw0Co1qL5rAVCPBT=+t+cBZULveBhiw@mail.gmail.com>
Subject: Re: Device or resource busy
From: Rohit Kulkarni <rmkulkar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi Alex,

I tried the "ip link set" command but the wpan interface doesn't go
down. The wpan1 device is already UP on boot and setting the channel
works fine but it fails with -EBUSY when trying to set pan_id.

Also, can you please point me to some existing code that uses the RAW
socket interface to communicate over 6LoWPAN?

Thanks again!
-Rohit

Here's the output from "ip link ..."(wpan-phy1 / wpan1 is the
at86rf212b device):

root@raspberrypi:~# iwpan list
wpan_phy wpan-phy1
supported channels:
page 0: 0,1,2,3,4,5,6,7,8,9,10
page 2: 0,1,2,3,4,5,6,7,8,9,10
current_page: 0
current_channel: 5
cca_mode: 1
tx_power: 0
wpan_phy wpan-phy0
supported channels:
page 0: 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26
page 1: 0,1,2,3,4,5,6,7,8,9,10
page 2: 0,1,2,3,4,5,6,7,8,9,10
page 3: 0,1,2,3,4,5,6,7,8,9,10,11,12,13
page 4: 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
page 5: 0,1,2,3,4,5,6,7
page 6: 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21
current_page: 0
current_channel: 0
cca_mode: 0
tx_power: 0

root@raspberrypi:~# ip link show wpan1
3: wpan1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 127 qdisc pfifo_fast state
UNKNOWN mode DEFAULT qlen 300
    link/ieee802.15.4 29:12:0f:cb:3a:39:8a:69 brd ff:ff:ff:ff:ff:ff:ff:ff

root@raspberrypi:~# ip link set wpan1 down

root@raspberrypi:~# ip link show wpan1
3: wpan1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 127 qdisc pfifo_fast state
UNKNOWN mode DEFAULT qlen 300
    link/ieee802.15.4 29:12:0f:cb:3a:39:8a:69 brd ff:ff:ff:ff:ff:ff:ff:ff

root@raspberrypi:~# ip link set wpan1 up

root@raspberrypi:~# ip link show wpan1
3: wpan1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 127 qdisc pfifo_fast state
UNKNOWN mode DEFAULT qlen 300
    link/ieee802.15.4 29:12:0f:cb:3a:39:8a:69 brd ff:ff:ff:ff:ff:ff:ff:ff
root@raspberrypi:~#

On Wed, Jan 21, 2015 at 1:14 AM, Alexander Aring <alex.aring@gmail.com> wrote:
> On Tue, Jan 20, 2015 at 05:58:45PM +0530, Rohit Kulkarni wrote:
>> Hi,
>>
>> When trying to set the pan_id for a node, I keep getting device or
>> resource busy. the "ifdown wpan1" says "interface wpan1 not
>> configured". "ifconfig wpan1 down" doesn't throw an error but it seems
>> to be a no-op.  (wpan0 is the fake radio interface and wpan1 is the
>> at86rf212b module. Also, the error's the same for the wpan0
>> interface). There was an email on the list about a month ago with the
>> same problem. Have there been any updates on the issue?
>>
>
> I can't reproduce the issue with the -EBUSY error. This should be fixed
> by a ifdown of the interface before.
>
> I don't know where the printout "interface wpan1 not configured" comes
> from.
>
> For doing a ifdown:
>
> I use "ip" rather than "ifconfig". I will show some example: at beginning
> we have a wpan0 interface which is down:
>
> `ip link show wpan0`:
>
> 2: wpan0: <BROADCAST,NOARP> mtu 127 qdisc fq_codel state DOWN mode DEFAULT group default qlen 1000
>     link/ieee802.15.4 94:8a:f5:4c:b3:b6:da:ff brd ff:ff:ff:ff:ff:ff:ff:ff
>
> after calling `ip link set wpan0 up` we have:
>
> 2: wpan0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 127 qdisc fq_codel state UNKNOWN mode DEFAULT group default qlen 1000
>     link/ieee802.15.4 94:8a:f5:4c:b3:b6:da:ff brd ff:ff:ff:ff:ff:ff:ff:ff
>
> Notice the netdev flag changes to "UP". Please check that on your side.
>
> The fakelb driver:
>
> Also I would not use the fake driver, there is a huge TODO list on my side
> for this driver. When I used this driver the first time, I detected
> that the driver received the frames which actual the driver actual sending,
> Which is wrong.
>
> Additional the fakelb driver makes no sense with only one fake registered
> phy. We need to update the whole driver and documentation. I would mark this
> driver as broken.
>
>> I'm using the tip of the bluetooth-next kernel and the release tarball
>> for wpan-tools-0.3 on a raspberry pi attached to an at86rf212b module
>> over spi. Please let me know if I missed out on any relevant info.
>>
>> Also, when I try to create a coordinator node, I get an "invalid
>> argument" error. I've added the netlink debug messages from this at
>> the bottom. Once, I can pair a node and a coordinator, I'd like to
>> send/receive messages between them from userland code (even broadcast
>> messages will do for now!). Is it too optimistic yet? Or has it been
>> done already? If it is already supported, even the simplest of code
>> samples will save me a lot of time! :)
>>
>
> Sorry, coordinator support isn't available yet. But you could use a node
> interface and sending via RAW socket interface. Furthermore the should be a
> coordinator interface and some netlink commands do to such MLME ops...
> then handling with coordinators would be easily. There exists also no MLME
> ops for node interfaces, so you need to do the pan association full
> inside userspace via RAW sockets.
>
> Currently, we handling dataframes via DGRAM and 6LoWPAN only.
>
> - Alex
