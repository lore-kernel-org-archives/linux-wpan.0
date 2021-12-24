Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E83C433F5
	for <linux-wpan@archiver.kernel.org>; Fri, 24 Dec 2021 19:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhLXTZF (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 24 Dec 2021 14:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhLXTZF (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Dec 2021 14:25:05 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F03C061401
        for <linux-wpan@vger.kernel.org>; Fri, 24 Dec 2021 11:25:05 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id a1so8263671qtx.11
        for <linux-wpan@vger.kernel.org>; Fri, 24 Dec 2021 11:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=bG9DSWQCCiPED0y+52uUiscZQ8hnoCCOpO3bvNOqiks=;
        b=tK7aK9gRDTn0zK5i9IJQypbdODw9ciZvQukGNkpuiCaLsenT88h2rFYe7O9+MFgibV
         WvV/Yi0GwUuNuxNnRCEz5++X5X2i+PgbAYkTCLzMcx6iNO23QVUwQnhs5wZO387NYBfs
         ocZ9nzeK+5uxjUrW/KeCTrGeNFMGXw62FeOqjrUb2RGK+xxAYJYU+H7rNOpJjIH7Zm/b
         KSNZYbN23Wo8854+C1aT+mqHAKlpcH7x0v5cEUiUiu4Qsvm0ji4XpkjceG4B6tYHMWjt
         7K/iivsZFR3URn/8Pw1cevsO/ephfFlZpOXNeJRWTpdDczlVsp+IzXduoCHRcNVB5Aie
         u2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=bG9DSWQCCiPED0y+52uUiscZQ8hnoCCOpO3bvNOqiks=;
        b=xgEPFCtSiy+x5apsT6xfIoQLnJFYyG4/YSZEaGiqZ+aZ5LsOzBOWrJxKmwQ7YXK9if
         hqRFmXlKGYtyrTFuVl32vx0Hk7MqX1o5VxpaQPV2wUov8nGAOE6EzNcm6gvGwginX0Nu
         fHlDHugxARwa4PJ/l9L4AH5sw5ScWHp0+HEwevZ/rumFyu5RShapUaJ4IujBwG84Yn6o
         7CtDS2WYdVSVqW58tePf70w2+YwXrUuV3ZlJxZ60xJM5kKfNqJcTi/yN38o/FvpH2Gn9
         9losB+1CKexqdFku1PuTvEmT4QEpCX9A03YFE1aYWqXWUWN6vHxvxHB4t6EXFdK4sUB8
         l6jA==
X-Gm-Message-State: AOAM531XlutKba+hiZdNXjEuoz8EAWY5cM0SFGJC4dj8NB1wltISXzhJ
        WCCpLbHBE3t/YUvx144JyWkbZvN0PEAZbnMrpTbh7A==
X-Google-Smtp-Source: ABdhPJy87a67wO1JNXlNuaxBQB9DxhKvCfTCs4TWGZ4erXZzaCPPAmc/o5O4WNvNU5yGY5D3yjSdGz3fjfKwzAGWYjA=
X-Received: by 2002:ac8:7d50:: with SMTP id h16mr6959438qtb.324.1640373903729;
 Fri, 24 Dec 2021 11:25:03 -0800 (PST)
MIME-Version: 1.0
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 24 Dec 2021 20:24:27 +0100
Message-ID: <CAG_fn=VDEoQx5c7XzWX1yaYBd5y5FrG1aagrkv+SZ03c8TfQYQ@mail.gmail.com>
Subject: Use of uninitialized value in atusb_set_extended_addr()
To:     David Miller <davem@davemloft.net>, stefan@datenfreihafen.org
Cc:     paskripkin@gmail.com, linux-wpan@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi folks,

KASAN* reported a use of uninitialized value in atusb_set_extended_addr().
The value came from kmalloc() in the same function, but then
apparently atusb_control_msg() returned 0, leaving `buffer` intact but
also avoiding the ret < 0 check.
Then the buffer got passed to
ieee802154_is_valid_extended_unicast_addr(), which used it in a
comparison - at that point KASAN reported an error.

* - this is an experiment to make KASAN detect some limited subset of
bugs caused by using uninitialized values.

Full report is below, I am not sure if it's enough to kzalloc the
buffer, or we'd better check the return values more carefully.

===========================
usb 7-1: ATUSB: AT86RF230 version 187
usb 7-1: Firmware: major: 3, minor: 0, hardware type: ATUSB (0)
usb write operation failed. (-71)
usb 6-1: dvb_usb_v2: will pass the complete MPEG2 transport stream to
the software demuxer
dvbdev: DVB: registering new adapter (Technisat CableStar Combo HD CI)
usb 6-1: media controller created
usb read operation failed. (-71)
usb write operation failed. (-71)
dvb_usb_az6007: probe of 6-1:0.0 failed with error -5
usb 6-1: USB disconnect, device number 6
usb 7-1: Firmware: build

BUG: KASAN: uninit-cmp in ieee802154_is_valid_extended_unicast_addr
include/linux/ieee802154.h:310 [inline]
BUG: KASAN: uninit-cmp in atusb_set_extended_addr
drivers/net/ieee802154/atusb.c:1000 [inline]
BUG: KASAN: uninit-cmp in atusb_probe.cold+0x29f/0x14db
drivers/net/ieee802154/atusb.c:1056
Uninit value used in comparison: 311daa649a2003bd
stack handle: 000000009a2003bd
 ieee802154_is_valid_extended_unicast_addr
include/linux/ieee802154.h:310 [inline]
 atusb_set_extended_addr drivers/net/ieee802154/atusb.c:1000 [inline]
 atusb_probe.cold+0x29f/0x14db drivers/net/ieee802154/atusb.c:1056
 usb_probe_interface+0x314/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x245/0xcd0 drivers/base/dd.c:596
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:751
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:781
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:898
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x226/0x4a0 drivers/base/dd.c:969
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xb83/0x1e20 drivers/base/core.c:3394
 usb_set_configuration+0x1041/0x19c0 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x245/0xcd0 drivers/base/dd.c:596
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:751
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:781
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:898
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x226/0x4a0 drivers/base/dd.c:969
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xb83/0x1e20 drivers/base/core.c:3394
 usb_new_device.cold+0x5f2/0x1018 drivers/usb/core/hub.c:2563
 hub_port_connect drivers/usb/core/hub.c:5353 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5643 [inline]
 hub_event+0x247a/0x4470 drivers/usb/core/hub.c:5725
 process_one_work+0x976/0x1620 kernel/workqueue.c:2298
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Memory allocated at:
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 kasan_color_object+0x17/0x80 mm/kasan/color.c:165
 __kasan_kmalloc mm/kasan/common.c:529 [inline]
 __kasan_kmalloc+0xe1/0xf0 mm/kasan/common.c:522
 kmalloc include/linux/slab.h:590 [inline]
 atusb_set_extended_addr drivers/net/ieee802154/atusb.c:983 [inline]
 atusb_probe+0x991/0x1280 drivers/net/ieee802154/atusb.c:1056
 usb_probe_interface+0x314/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x245/0xcd0 drivers/base/dd.c:596
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:751
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:781
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:898
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x226/0x4a0 drivers/base/dd.c:969
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xb83/0x1e20 drivers/base/core.c:3394
 usb_set_configuration+0x1041/0x19c0 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x245/0xcd0 drivers/base/dd.c:596
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:751
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:781
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:898
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x226/0x4a0 drivers/base/dd.c:969
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xb83/0x1e20 drivers/base/core.c:3394
 usb_new_device.cold+0x5f2/0x1018 drivers/usb/core/hub.c:2563
 hub_port_connect drivers/usb/core/hub.c:5353 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5643 [inline]
 hub_event+0x247a/0x4470 drivers/usb/core/hub.c:5725
 process_one_work+0x976/0x1620 kernel/workqueue.c:2298
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

CPU: 1 PID: 29149 Comm: kworker/1:14 Not tainted 5.16.0-rc6+ #111
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
Workqueue: usb_hub_wq hub_event
