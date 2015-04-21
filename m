Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34083 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbbDUHKF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 21 Apr 2015 03:10:05 -0400
Received: by wicmx19 with SMTP id mx19so56635264wic.1
        for <linux-wpan@vger.kernel.org>; Tue, 21 Apr 2015 00:10:04 -0700 (PDT)
Date: Tue, 21 Apr 2015 09:09:53 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Network adaptor for the liux 802.15.4 stack
Message-ID: <20150421070750.GA1118@omega>
References: <CANG3NKzjqL=5_-PdXQOSciD04TYOU7hAJ5jpamMbkuHPbH=QuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANG3NKzjqL=5_-PdXQOSciD04TYOU7hAJ5jpamMbkuHPbH=QuQ@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Kristoffer =?utf-8?Q?=C3=96dmark?= <kristofferodmark90@gmail.com>
Cc: werner@almesberger.net, linux-wpan@vger.kernel.org

Hi,

On Mon, Apr 20, 2015 at 11:09:49PM +0200, Kristoffer Ödmark wrote:
> Hi, I am developing a device that can send and recieve 802.15.4 frames
> to a computer over usb.
> 

okay. First, I already answered a similar question, please see [0].

> Since you seem to have done a lot of work with this kind of thing, is
> there someway that i can create  a virtual interface, much like the
> TUN/TAP interfaces that are available for us right now?
> 

So you want to have some special "driver" which can accept frames from
userspace to redirect them in the kernelspace to the driver and the
interface is type of a WPAN interface.

This doesn't exist right now, maybe you can setup such enviornment with
the serial driver (I think this is what Tony Cheanau did at [1]). See
[2] - right side, I think then you need to remove the green box and you
have your /dev/fakeserial0 device, but this methods required the serial
driver which isn't mainline yet. The interface at /dev/fakeserial0 would
be the serial protocol then, see my other mail for usb dongles at [0].

> What would i have to do to get my raw serialized 802.15.4 frames into
> the linux-zigbee stack? I watched your talk about that on youtube.
> Originally i was going to use the contiki solution, but since the
> stack in linux seems to be pretty okay thanks to you i would prefer
> that way.
> 

I would say you need to decide if "atusb" or "serial" based firmware for
your usb dongle device. If you have already a serial connection then I
think you already decide to use the serial protocol, which you can see
mostly see how it works at serial driver [3].

For atusb, your firmware need to speak the "atusb" protocol which is simple
if the transceiver is a at86rf2xx based. The atusb driver isn't mainline
yet but in a good state. (Means better than serial).


For serial communication you need to speak the serial protocol on firmware
and port the serial driver to newer kernel release.

Maybe you can also generate some crazy setup which do a adaptation from
/dev/ttyUSB0 to /dev/fakeserial0 in userspace, then you could use your already
existing serial protocol from /dev/ttyUSB0 and translate it to /dev/fakeserial0.
If you don't have access to the firmware, then this would be the only choice
for you.


The bad messages this is not all mainline and you need to port it, if
you do that I would be very happy about to see patches. I cc here Werner
Almesberger, the creator of atusb.

- Alex

[0] http://www.spinics.net/lists/linux-wpan/msg01591.html
[1] https://github.com/tcheneau/virtual-ieee802154-serial
[2] https://github.com/tcheneau/virtual-ieee802154-serial/blob/master/figures/fakeserial-architecture.png
[3] https://github.com/linux-wpan/linux-wpan-next/commit/546618171de2be30236aab86f3ee323b425e2bf5
