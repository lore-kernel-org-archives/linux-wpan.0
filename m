Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:34722 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbbCaHsR (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 31 Mar 2015 03:48:17 -0400
Received: by wgbdm7 with SMTP id dm7so9501373wgb.1
        for <linux-wpan@vger.kernel.org>; Tue, 31 Mar 2015 00:48:16 -0700 (PDT)
Date: Tue, 31 Mar 2015 09:48:10 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 15.4 serial driver
Message-ID: <20150331074807.GA21839@omega>
References: <CABA_Ov2K0vJD5dDur7Vwa3h3AyLoXKEUyk5cDK9e_Qf-k_LJ1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABA_Ov2K0vJD5dDur7Vwa3h3AyLoXKEUyk5cDK9e_Qf-k_LJ1Q@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Wei Chen <chenwei.sh99@gmail.com>
Cc: werner@almesberger.net, linux-wpan@vger.kernel.org

On Tue, Mar 31, 2015 at 12:07:51AM -0700, Wei Chen wrote:
> Alex,
> 
> I'm trying to follow the 6lowpan demos you did, and trying to write a
> driver a new hardware 15.4 dongle. But I'm confused about the status of

you mean a usb dongle?

> 15.4 driver. The mainline does not have either atusb or serial interface
> driver under ieee802154 dir. Will the serial driver be integrated on
> mainline?

If usb dongle I would be very happy to use the existing atusb protocol,
then you need write a firmware only and the driver already exists.

That's my idea to support the RAVENRZUSBSTICK [0]. The atusb and
RAVENRZUSBSTICK use both some atmel mcu and a at86rf23x. The
RAVENRZUSBSTICK uses the at86rf230 and I heard it's a little bit harder
to use them as the at86rf231.

The idea is to create a atusb firmware project to support building both
of them by replacing some $BOARD_CONFIG file.



Now to your questions:

atusb:

The atusb is in a very good state, except one thing. It does not support
async xmit handling. Maybe when I investigate ~2 days then I can bring
async xmit support, it's not so much complicated. You are welcome to
support it. The lastest driver version which should also easily
cherry-picked on current mainline, the lastest version can be found at [1].

For the xmit_async handling:

You need to use xmit_async instead xmit_sync, but this reuquire a async
usb handling inside this callback.

Firmware:

You can find the actual atusb firmware at [2].

serial driver:

That's not in a good state und if you want to support a "usb dongle" I don't
recommend to making some protocol stuff over usb. You have some usb
timing constraints and the atusb firmware tries to handle that with some
caching functionality etc.

The serial driver is okay for connecting to an UART bus only.

Nevertheless you can also try to get the serial driver mainline. I will
review the driver. Lastest version is [3]. But this driver is in an
horrible state, which begins with the name of this driver "serial"
which ends in a modulename "serial.ko". :-)



I hope I could answer your questions. Please let me know your further
handling about your dongle project.

- Alex

[0] http://www.atmel.com/tools/rzusbstick.aspx
[1] https://github.com/linux-wpan/linux-wpan-next/commit/60301df6c1f2833b1af982e3647e958414a76735
[2] http://projects.qi-hardware.com/index.php/p/ben-wpan/source/tree/master/atusb/fw
[3] https://github.com/linux-wpan/linux-wpan-next/commit/546618171de2be30236aab86f3ee323b425e2bf5
