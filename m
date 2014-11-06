Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:44692 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbaKFLOV (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 6 Nov 2014 06:14:21 -0500
Received: by mail-wi0-f171.google.com with SMTP id r20so1106570wiv.16
        for <linux-wpan@vger.kernel.org>; Thu, 06 Nov 2014 03:14:20 -0800 (PST)
MIME-Version: 1.0
From: Henning Rogge <hrogge@gmail.com>
Date: Thu, 6 Nov 2014 12:14:00 +0100
Message-ID: <CAGnRvuo+4fpbn6TTzFujaJ_agf+sCZxV1T5a9hmmZ4z29OCEHA@mail.gmail.com>
Subject: 6lowpan with external radio
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,

I am working with an external VHF radio attached over a serial
connection (USB serial at the moment) and looking for a way to use the
Linux 6lowpan stack with this radio.

Is there a way to get a TUN/TAP equivalent for 6lowpan, just getting
the raw frames back through a socket into userspace?

Henning Rogge
