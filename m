Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:35519 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753552AbdGXNqB (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 24 Jul 2017 09:46:01 -0400
Received: by mail-wr0-f174.google.com with SMTP id k71so52927569wrc.2
        for <linux-wpan@vger.kernel.org>; Mon, 24 Jul 2017 06:46:01 -0700 (PDT)
MIME-Version: 1.0
From: Amitkumar Karwar <amitkarwar@gmail.com>
Date: Mon, 24 Jul 2017 19:15:59 +0530
Message-ID: <CAEhWJFkiL5Gvcm1vn4UY3=vH98FRUvAv_fdTN=je274Ctxc2og@mail.gmail.com>
Subject: Query about ZigBee driver
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi All,

We have a proprietary ZigBee stack running in our firmware. ZigBee
profiles run in application. These profiles talk with our thin ZigBee
driver through netlink sockets.

We wanted to submit this ZigBee driver to Linux kernel.
Please let me know if this is possible.

Writing ieee802154 based driver doesn't suit our requirement, as
mac802154 and ZigBee stack are present in firmare.
Please guide.

Regards,
Amitkumar
