Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:45239 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364AbbETN2Q (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 May 2015 09:28:16 -0400
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH atubs-fw 0/4] ATUSB firmware changes towards a 0.2 release
Date: Wed, 20 May 2015 15:18:10 +0200
Message-Id: <1432127894-4760-1-git-send-email-stefan@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, werner@almesberger.net, Stefan Schmidt <stefan@datenfreihafen.org>

Hello.

Nothing to be appliad to the kernel but rather the atusb firmware repo. Just
sending it here as it is releated to the mainline driver and the device users
are reading here.

These are the four patches I consider we need to have a working 0.2 release.
The revert might be only needed for my qemu setup with USB passthrough, but
without it I'm not able to get the device to show up in qemu. Thoughts
appreciated.

Using RX_AACK_ON sounds like a good idea as we loose nothing but work also work
well with nodes using ARET.

Bumping to version 0.2 and adding the need magic to add a valid DFU suffix to
the firmware file. I will followup with a mail attaching the binary I'm using
right now and I consider the final 0.2 if everyone agrees with these patches.

Stefan Schmidt (4):
  Revert "atusb/fw/usb/: enable MCU reset on USB bus reset after config
    selection"
  atusb/fw: Use RX_AACK_ON instead of RX_ON in the firmware.
  atusb/fw: Add build system support for adding a DFU suffix to the fw
    file
  atusb/fw: Bump minor version to mark first public release.

 atusb/fw/Makefile            | 17 +++++++++++++----
 atusb/fw/include/atusb/ep0.h |  3 ++-
 atusb/fw/mac.c               |  6 +++---
 atusb/fw/usb/atu2.c          |  7 +------
 atusb/fw/usb/usb.c           |  1 -
 atusb/fw/usb/usb.h           |  1 -
 6 files changed, 19 insertions(+), 16 deletions(-)

regards
Stefan Schmidt

-- 
2.1.0

