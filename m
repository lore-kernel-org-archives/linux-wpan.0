Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:35897 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbbDUPzg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 21 Apr 2015 11:55:36 -0400
Received: by lbbqq2 with SMTP id qq2so159088447lbb.3
        for <linux-wpan@vger.kernel.org>; Tue, 21 Apr 2015 08:55:35 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 21 Apr 2015 11:55:35 -0400
Message-ID: <CAHwW560VTApCL2a4c8uOMC2u-bWzenTf0vwH0pbeLZ3xNLuCOA@mail.gmail.com>
Subject: atusb availability
From: Geoff Chapman <geoff.chapman@mmbresearch.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: werner@almesberger.net

Hello Mr. Almesberger,

My name is Geoff Chapman, and I am working on project to setup a
simple 6loWPAN network between two laptops running Linux.  I am very
interested in your work on the atusb device detailed at [0], and would
like to use the device in my project.  On each laptop, I would like to
use one of your atusb devices to implement the 802.15.4 MAC/PHY, while
using the 6loWPAN stack in the linux kernel. I picture something like
the following setup for each laptop:


Linux Laptop:

        | Application Layer |
                       |
                socket API
                       |
        |  6LoWPAN stack |
                       |
                       |
                       <-----------------USB---------------> atusb
device implementing 802.15.4 MAC/PHY (ATMega32U2 + at86rf233)


I have tried purchasing two atusb devices at [1] without any luck, as
they no longer sell the devices.
I have two questions:

1. Do you have any atusb devices available for purchase?
2. If you have none for purchase, do you have the schematics available
that I can use to wire-up my own atusb device?  The schematic link on
your site [2] seems to be broken.

[0] http://downloads.qi-hardware.com/people/werner/wpan/web/
[1] http://pulster.eu/index.html?d__atusb__NanoNote_wireless_card__atusb_1185.htm
[2] http://projects.qi-hardware.com/schhist/atusb/

I would greatly appreciate any assistance or advice you could give me.
Thank-you very much for your time.

Sincerely,

--Geoff
