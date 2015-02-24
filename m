Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:49671 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbbBXPzM (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 24 Feb 2015 10:55:12 -0500
Received: by mail-wi0-f174.google.com with SMTP id em10so26550401wid.1
        for <linux-wpan@vger.kernel.org>; Tue, 24 Feb 2015 07:55:11 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv4 bluetooth-next 0/2] at86rf230: add support for xtal trim register
Date: Tue, 24 Feb 2015 16:54:59 +0100
Message-Id: <1424793301-29931-1-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Werner Almesberger <werner@almesberger.net>, Thomas Stilwell <stilwellt@openlabs.co>

Hi,

I want to clarify how xtal_trim value is calculated now.

First of all the xtal_mode set to 0x5 will require a 16 Mhz clock signal at
pin 26. I don't have such at86rf2xx board which can do that, so I don't want
to support it right now.

IMPORTANT:
The xtal_mode for external frequency differs per at86rf2xx transceiver. For
at86rf230/at86rf231 it's 0x4. For at86rf233 it's 0x5. (Thanks Werner
Almesberger who pointed this out). That doesn't matter right now, because we
don't change the "normal" mode.


The xtal_trim is only necesarry for external crystal, when xtal_mode == 0xF.
The xtal_trim value is calculated by:

CL = capacitor of used crystal
CX = connected capacitors at xtal pins
CPAR = in all at86rf2xx datasheets this is a constant value 3 pF,
       but this is different on each board setup. You need to fine
       tuning this value via CTRIM.
CTRIM = variable capacitor setting. Resolution is 0.3 pF range is
        0 pF upto 4.5 pF.

CL = 0.5 * (CX + CTRIM + CPAR)


Examples:

On atben [0]:

CL = 8 pF
CX = 12 pF
CPAR = 3 pF (We assume the magic constant from datasheet)
CTRIM = 0.9 pF

(12+0.9+3)/2 = 7.95 which is nearly at 8 pF

openlabs [1]:

CL = 16 pF
CX = 22 pF
CPAR = 3 pF (We assume the magic constant from datasheet)
CTRIM = 4.5 pF

(22+4.5+3)/2 = 14.75 which is the nearest value to 16 pF

For more information it's the section "Integrated Oscillator Setup" inside
the at86rf2xx datasheets. (In my case 8111C–MCU Wireless–09/09).

For a better calculation of the CPAR value, Werner Almesberger developed some
diagnostic tool [2], which I don't tried out yet.

- Alex

[0] http://projects.qi-hardware.com/index.php/p/ben-wpan/source/tree/master/atben
    (atben.sch, requires kicad tool)
[1] http://openlabs.co/OSHW/Raspberry-Pi-802.15.4-radio-files/rpi802154-r1.pdf
[2] http://projects.qi-hardware.com/index.php/p/ben-wpan/source/tree/master/tools/atrf-xtal

changes since v4:
 - remove platform data from at86rf230_local
 - add note in cover-letter because at86rf2xx have different xtal_mode values

changes since v3:
 - remove setting of xtal_mode. Instead we setting xtal_trim only.

changes since v2:
 - copy platform data to driver allocated space

Cc: Werner Almesberger <werner@almesberger.net>
Cc: Thomas Stilwell <stilwellt@openlabs.co>

Alexander Aring (2):
  at86rf230: copy pdata to driver allocated space
  at86rf230: add support for external xtal trim

 .../bindings/net/ieee802154/at86rf230.txt          |  3 +
 drivers/net/ieee802154/at86rf230.c                 | 66 +++++++++++++---------
 include/linux/spi/at86rf230.h                      |  1 +
 3 files changed, 42 insertions(+), 28 deletions(-)

-- 
2.3.0

