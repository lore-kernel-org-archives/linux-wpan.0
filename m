Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:64412 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329AbaIHJxd (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 8 Sep 2014 05:53:33 -0400
Received: by mail-we0-f169.google.com with SMTP id w61so407866wes.28
        for <linux-wpan@vger.kernel.org>; Mon, 08 Sep 2014 02:53:32 -0700 (PDT)
Date: Mon, 8 Sep 2014 11:53:26 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Serial-driver
Message-ID: <20140908095324.GA5517@omega>
References: <CAMyBxbYwTSigRyFD+qvfW0RZHXBmdqWP9XCym3U1HKdqWooTxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMyBxbYwTSigRyFD+qvfW0RZHXBmdqWP9XCym3U1HKdqWooTxw@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Thomas =?utf-8?Q?K=C3=BChnel?= <kuehnelth@googlemail.com>
Cc: linux-wpan@vger.kernel.org

Hi Thomas,

On Mon, Sep 08, 2014 at 11:07:27AM +0200, Thomas Kühnel wrote:
> Hi,
> 
> I own a RaspBee[1] Transceiver, that I wanted to use on the Raspberry
> Pi. On the wiki I noticed the page about the serial driver[2] which
> sounded promising. So I used the patch[3] with some small changes to
> make it work with the current net-next kernel and wrote my own
> firmware for the RaspBee[4]. The firmware uses the µRacoli library for
> I/O and network communication, so it should also work on other devices
> supported by the library.

nice.

> So my actual question is, why is the serial driver not part of
> net-next? Was it just never sent to the mailing list for review or are
> there any problems that need to be fixed first?
> 
> 

First I need to say that I am current working on a complete rework of
802.15.4 and mac handling. Adding new drivers makes more work for me to
rebase this stuff according the new changes (I don't touched the driver
layer too hard so this should be okay). Repository for the rework is
[1]. I drifted too much in my git history and need to clean it up at the
end. It's just a local working branch for me. You need new userspace
software for it which is located at [2].

Both branches are currently under heavy programming by me.

I know the serial driver, there exists also a open firmware for the
econotag to support this serial protocol.

I already thought also about a contiki app which offer this serial
interface, then contiki would run as firmware. Then you could use any
contiki sensornode with linux stack. But nevertheless, just an idea
which pending around.

The serial driver specification supports only basic functionality about
802.15.4. There was also a idea for a serialv2 interface by tony
cheneau, see [0].

I need to admit, I never worked with the serial driver/interface. But
what I can see at the current driver is that there much places which
need to rework because it's not in a mainline able state. For example
some easy issues like dev_foo instead printk.

I don't take a closer look now, but I would review it. I currently think
that's it's not a good idea to add new drivers before the rework is
finished (If the rework ever comes mainline, but it should).

The mac layer have at the moment too many issue, I mean the basic stuff
works but then nothing more and it's hard to make a more correct
handling of this at the current situation.

I would give you the advice that you base the new implementation on the
new rework from branch [1]. I will help you there, then we review the
code and the new serial driver (what v1 specification says will be added
to the rework). When the rework becomes mainline, the serial driver
becomes, too. Please let me know if you like to do this, otherwise...
maybe I will do it when I have time for this.



For the general specification. Maybe you want to add more functionality,
like setting of ARET or promiscous mode. We should add some spec
documentation in wpan-misc repository [3]. There we should add something
like that. We should clear the master branch and add the serialv1 spec.
I would not adding the serial driver before that. Just send patches for
this with tag "wpan-misc" for some documentation about the current v1
spec. I will add this then.


Sorry, but I don't want to add new drivers since we don't have the
rework mainline. I hope you understand that.

- Alex

[0] https://github.com/linux-wpan/ieee802154-serial-protocol-version2
[1] https://github.com/linux-wpan/linux-wpan-next/tree/wpan_rework_rfc
[2] https://github.com/linux-wpan/wpan-tools
[3] https://github.com/linux-wpan/wpan-misc
