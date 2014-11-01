Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:51420 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758153AbaKAIr2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 1 Nov 2014 04:47:28 -0400
Received: by mail-wg0-f44.google.com with SMTP id x12so7439896wgg.31
        for <linux-wpan@vger.kernel.org>; Sat, 01 Nov 2014 01:47:27 -0700 (PDT)
Date: Sat, 1 Nov 2014 09:47:21 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [Linux-zigbee-devel] Cannot get MRFs talking. Not sure what I've
 done wrong.
Message-ID: <20141101084719.GA31204@omega>
References: <01C25E88-7F4B-4669-9BB6-AED08C4B66EE@elephantheadsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01C25E88-7F4B-4669-9BB6-AED08C4B66EE@elephantheadsoft.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Dr. Aditya Nagrath PhD" <anagrath@elephantheadsoft.com>
Cc: linux-zigbee-devel@lists.sourceforge.net, linux-wpan@vger.kernel.org

Hi,

On Sat, Nov 01, 2014 at 02:01:55AM -0600, Dr. Aditya Nagrath PhD wrote:
> I am trying to get a MRF24j40 on a BeagleBone Black to talk to an arduino with a mrf24j40.  I have successfully communicated arduino to arduino but as of yet have not been able to receive the packets being sent out on the BBB.
> 
> The setup:  I have GPIO_13 going to reset (pin 2), GPIO_14 going to wake (pin 3) and GPIO_29 going to interrupt (4).  The 3.3v is going to vin on 10 and ground on pin 1.   I am using SPI1 with the HDMI ports disabled.  D0 is mapping to pin 7 (SDO) and D1 is mapping to pin 5 (SDI), P9.31 the clock goes to pin 6 and P9.28 goes to pin 8.
> 
> I have been able to log into the BBB via ssh.  I then load the cape for the MRF24j40 using the echo to /sys/devices/bone_capemgr.9/slots
> 
> This appears to load the driver properly.
> 
> I have then been able to do:
> 
>     iz listphy
>     iz: /lib/arm-linux-gnueabihf/libnl-genl-3.so.200: no version information available (required by iz)
>     iz: /lib/arm-linux-gnueabihf/libnl-3.so.200: no version information available (required by iz)
>     wpan-phy0  IEEE 802.15.4 PHY object
>         page: 0  channel: n/a
>         channels on page 0: 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26
> 
>     iz add wpan-
>     iz: /lib/arm-linux-gnueabihf/libnl-genl-3.so.200: no version information available (required by iz)
>     iz: /lib/arm-linux-gnueabihf/libnl-3.so.200: no version information available (required by iz)
>     Registered new device ('wpan0') on phy wpan-phy0
> 
> I decided to set all my addresses to simple things on the arduino side in case there is some sort of endian problem so the pan id is 0, the address of the sender is 0 and it sends the data to 1, thus I try to set the beaglebone to pan id 0, address 1 with a destination address of 0.
> 
>     root@beaglebone:~# iz set wpan0 0 1 12
>     iz: /lib/arm-linux-gnueabihf/libnl-genl-3.so.200: no version information available (required by iz)
>     iz: /lib/arm-linux-gnueabihf/libnl-3.so.200: no version information available (required by iz)
>     ifconfig wpan0 up
> 
> Then I run
> izchat 0 1 0
> 
> I get nothing on the BBB side even though the other side is constantly transmitting... and when I type into izchat, I do not receive anything on the other side.
> 
> Any help here would be appreciated... I just want to see some data before I start coding.  Like I said, this has been tested arduino to arduino and does not have problems.

Mailinglist changed to [0].

Please let me know which kernel, libnl3 and lowpan-tools version do you
use.

Also I need to notice you that I am working on a big rework. With new
userspace tools, etc... I need some time to bring it mainline. The bring
it mainline thing is currently in progress.

I am very busy right now.

- Alex

[0] http://vger.kernel.org/vger-lists.html#linux-wpan
