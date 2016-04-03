Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f194.google.com ([209.85.217.194]:34503 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbcDCSfb (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 3 Apr 2016 14:35:31 -0400
Received: by mail-lb0-f194.google.com with SMTP id vk4so18100068lbb.1
        for <linux-wpan@vger.kernel.org>; Sun, 03 Apr 2016 11:35:31 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 3 Apr 2016 22:35:29 +0400
Message-ID: <CAH+RWqFxO9VgVgbyxjefot8JLnF_asKzbGh9AVtu2GW9Z8uqxA@mail.gmail.com>
Subject: Reversed Payload Bits?
From: Remi Philippe <remi+wpan@linqio.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello,
A generic question, have you ever run into issues such as payload bits
arriving reversed (AT86RF215 to CC1200 on Contiki, but I guess it
would be the same for AT86RF230)?

At first look it could have been and endianess problem, but I don't see why...

Thanks,
Remi
