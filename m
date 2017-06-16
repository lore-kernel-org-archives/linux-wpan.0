Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:35356 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752619AbdFPMAR (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 16 Jun 2017 08:00:17 -0400
Received: by mail-qt0-f172.google.com with SMTP id w1so59468902qtg.2
        for <linux-wpan@vger.kernel.org>; Fri, 16 Jun 2017 05:00:17 -0700 (PDT)
MIME-Version: 1.0
From: JANARDHANACHARI KELLA <eni.chari@gmail.com>
Date: Fri, 16 Jun 2017 17:30:14 +0530
Message-ID: <CAAK7Ti--Z6rpE8rfUcCRADc8YJ8pWcw65dsOZnm3bx+rofWirw@mail.gmail.com>
Subject: ieee802154: bad frame received (type = 0)
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,

I am trying to use the at86rf233 radio with raspberry pi3 and kernel
4.4.50. that kernel has cloned from git/raspberrypi.

i have tested, Tx packet is going out fine. but i am facing an issue
with receiving packet, "ieee802154: bad frame received (type = 0)"
message is coming.

and also i have checked  that SPI speed 3000000 is there.

how can i resolve this issue?



-- 
Thanks & Regards

Janardhanachari Kella
