Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from act-MTAout5.csiro.au ([150.229.7.42]:11380 "EHLO
        act-MTAout5.csiro.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfBUAlU (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 20 Feb 2019 19:41:20 -0500
From: <Seung.Jang@data61.csiro.au>
Subject: Running OpenThread on fakelb
Date: Thu, 21 Feb 2019 00:31:19 +0000
Message-ID: <dec2e8f279a14dc0b29dd92707e83319@exch1-mel.nexus.csiro.au>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi all,

I'm trying to run OpenThread on fakelb, and I'd like to ask about this topi=
c.

My test environment is Ubuntu 16.04 (kernel version 4.15).

I followed the instruction in Alex's announcement [1]. From one of ot-cli, =
I was able to ping the other ot-cli. At the same time, I tried to sniff pac=
kets of lowpan0, ot0, ot1, and monitor0 with wireshark. But wireshark detec=
ted nothing. When I compiled the ot-cli, I applied '--enable-af-packet'.

Do you have any idea about this? Could you share any experience regarding t=
his?

- Seung

[1] https://www.spinics.net/lists/linux-wpan/msg04167.html
