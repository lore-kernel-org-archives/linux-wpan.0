Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:51903
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S967750AbdIZJ04 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 26 Sep 2017 05:26:56 -0400
Subject: Re: new atusb firmware candidate
References: <CAOHTApjuwS_tsaHzzvsT=LGDTM+8Ekc8=qLLRTqkdSANST20bw@mail.gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <3b39d66c-9ec5-56b1-c612-2bfdf10d6a93@osg.samsung.com>
Date: Tue, 26 Sep 2017 11:26:52 +0200
MIME-Version: 1.0
In-Reply-To: <CAOHTApjuwS_tsaHzzvsT=LGDTM+8Ekc8=qLLRTqkdSANST20bw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>

Hello.

On 09/25/2017 03:35 PM, Alexander Aring wrote:
> Hi,
> 
> according to qi-hardware irc channel, I got notice about this transceivers [0].
> Maybe a new atusb candidate? Or maybe they already use a non-upstream
> implementation? :-)

Looking at their manual they are focuses on delivering a Arduino compatible solution.

> Prices are okay (better than the very expensive one from atmel).

Prices are good and they are still available.

I had a quick look at their schematics in the user manuals:
http://freaklabsstore.com/pub/FREAKUSB-900MHz%20v1.1%20Datasheet.pdf
http://freaklabsstore.com/pub/FREAKUSB-2.4GHZ%20v1.1a%20Datasheet.pdf

They use the at86rf231 and at86rf212 transceivers (I still hope for a 215 device)

The problem I see is that USB is connected to a FTDI usb serial bridge chip instead directly to the Atmel MCU.

I have no idea if the FTDI can be swichted into a passthrough mode. If that is the case re-using the existing atusb firmware and USB
protocol to the kernel driver should not be to hard for someone interested.

If the passthrough is not possible and the whole communication protocol has to go over the serial line that would be significant more work.
Adapting the protocol over a serial line, adapting firmware and adapting the kernel driver.

Doable, but significantly more work compared to say the hulusb support in ATUSB which have been added recently.

If someone wants to poke at this I would be happy to give some guidance.

regards
Stefan Schmidt
