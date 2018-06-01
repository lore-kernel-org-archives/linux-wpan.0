Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:36635 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753080AbeFAQPE (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 1 Jun 2018 12:15:04 -0400
Received: by mail-io0-f169.google.com with SMTP id d73-v6so30285036iog.3
        for <linux-wpan@vger.kernel.org>; Fri, 01 Jun 2018 09:15:04 -0700 (PDT)
Date: Fri, 1 Jun 2018 12:14:52 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: ndo_star_xmit() - resevered head and tailroom
Message-ID: <20180601161432.ro2lop4tz6hc43pv@x220t>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: stefan@osg.samsung.com, linux-wpan@vger.kernel.org, kernel@mojatatu.com

Hi netdev community,

I am again on bug fixing in 6lowpan branch and thought that my
needed_headroom and needed_tailroom of net_device are available inside
my ndo_start_xmit() callback.

In case of a UDP socket, it was not the case. I send a fix now to use
skb_expand_copy() to make sure this space is available. (I need to
unshare the buffer anyway).

I am just curious is this suppose to work like that? I cannot believe
that I need to run a realloc() inside my ndo_start_xmit(). If possible,
when the net_device is known at socket layer it should allocate the
necessary space and I thought this is the designed transmit flow.

- Alex
