Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:58890 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbaHSNdb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Aug 2014 09:33:31 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so9761935pdj.14
        for <linux-wpan@vger.kernel.org>; Tue, 19 Aug 2014 06:33:30 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 19 Aug 2014 14:33:29 +0100
Message-ID: <CAJ018wBU9OXQfrVr3x+EoeT0V8CM+s80xcCUvM4Urj-zdtHcsA@mail.gmail.com>
Subject: mac802154: TX results and ACK processing
From: =?UTF-8?Q?Jo=C3=A3o_Pedro_Taveira?= <joao.p.taveira@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi to all,

I'm working on a RPL implementation to linux. It works with
rpl_of_of0, but to get rpl_of_mhrof working, it requires ETX
calculations. In order to get ETX working on linux, it would be
required to get mac802154 Tx results. Are you planning on get track of
radios autoacks and/or transceivers Tx results?

RPL must not know anything about 6lowpan, but since it will use link
metrics, the RPL mechanisms should be able to get neighbors links
stats.

What's your opinion?

Best Regards,
João Pedro Taveira
