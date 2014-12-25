Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:49539 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbaLYLa4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 25 Dec 2014 06:30:56 -0500
Received: by mail-wi0-f173.google.com with SMTP id r20so15379823wiv.6
        for <linux-wpan@vger.kernel.org>; Thu, 25 Dec 2014 03:30:55 -0800 (PST)
Date: Thu, 25 Dec 2014 12:30:49 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 0/7] ieee802154: 6lowpan: remove full-size
 calculation workarounds
Message-ID: <20141225113047.GA27009@omega>
References: <1419344909-16007-1-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1419344909-16007-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Jukka Rissanen <jukka.rissanen@linux.intel.com>

Marcel,

please drop this series. I reconsider my change and detect that IPHC
uncompression use "uh->len = htons(skb->len + sizeof(struct udphdr))"
for udp next header compression.

This patch introduce now a iphc uncompression after first fragment and
skb->len isn't the full payload there. Need to look how we can deal with
that now. I really like to remove these workarounds to run a 6LoWPAN
header parse twice.

When the first fragment arrived we know the full payload but we can't
set skb->len with this value.

Need to look for another solution for this which can be used by btle
and 802154 6LoWPAN.

- Alex
