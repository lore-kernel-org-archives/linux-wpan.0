Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:38340 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbbEDSfW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 4 May 2015 14:35:22 -0400
Received: by wiun10 with SMTP id n10so119800841wiu.1
        for <linux-wpan@vger.kernel.org>; Mon, 04 May 2015 11:35:21 -0700 (PDT)
Date: Mon, 4 May 2015 20:35:18 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: for all openlabs tranceiver users
Message-ID: <20150504183515.GD2385@omega.Speedport_W_921V_1_37_000>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: stilwellt@openlabs.co

Hi,

maybe you read the other mail about the RPi and openlabs transceiver
module.

at86rf233 datasheet says 7.5 Mhz is the highest clock, but since the RPi
clock can run at 7.35 Mhz I expierence issues with the openlabs transceiver.

Set the max spi clock to 6 Mhz solved this issue. Please update the
device tree according to that value.

I tested two different transceivers with the same issue at 7.35 Mhz spi
clock.

Thanks.

- Alex
