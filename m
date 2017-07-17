Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:35564 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbdGQQeN (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 17 Jul 2017 12:34:13 -0400
Received: by mail-wr0-f180.google.com with SMTP id w4so25460858wrb.2
        for <linux-wpan@vger.kernel.org>; Mon, 17 Jul 2017 09:34:12 -0700 (PDT)
Received: from omega (p20030064A906A706DC29E5DE2A7F1175.dip0.t-ipconnect.de. [2003:64:a906:a706:dc29:e5de:2a7f:1175])
        by smtp.gmail.com with ESMTPSA id n2sm49863wmd.19.2017.07.17.09.34.10
        for <linux-wpan@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jul 2017 09:34:10 -0700 (PDT)
Date: Mon, 17 Jul 2017 18:34:06 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: making spi drivers half-duplex/3wire ready
Message-ID: <20170717163404.thhymcxawasfvbyv@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,

I messed up the spi transfer stuff in at86rf230 driver. Some people
reported issues with half-duplex and 3wire spi controllers.

The issue is that we use only one tranfer buffer for one message for tx
and rx. I thought the spi subsystem can deal with that and just not
overwrite rx buf position with tx buf position on all other types.

No, what we need to do is:

spi_message_add_tail($TX_ONLY_PART, &state->msg);
spi_message_add_tail($RX_ONLY_PART, &state->msg);

and do TX only and then afterwards RX only. Seems that is what the SPI
subsystem wants then..., otherwise it will fail at [0].

In at86rf230/mrf24j40 only low-level async setup is affected. I hope
regmap can deal with half-duplex/3wire stuff.

Just that everybody is aware about this issue now. :-)

- Alex

[0] http://elixir.free-electrons.com/linux/latest/source/drivers/spi/spi.c#L2610
