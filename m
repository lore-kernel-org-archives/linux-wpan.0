Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:39705 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753189AbeGBSks (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 2 Jul 2018 14:40:48 -0400
Received: by mail-it0-f67.google.com with SMTP id p185-v6so13270199itp.4
        for <linux-wpan@vger.kernel.org>; Mon, 02 Jul 2018 11:40:47 -0700 (PDT)
Date: Mon, 2 Jul 2018 14:40:44 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: [PATCH] ieee802154: 6lowpan: set IFLA_LINK
Message-ID: <20180702184044.2zwdfhfqlasqjfbp@x220t>
References: <20180702092147.56331-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180702092147.56331-1-lkundrak@v3.sk>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

Hi,

On Mon, Jul 02, 2018 at 11:21:47AM +0200, Lubomir Rintel wrote:
> Otherwise NetworkManager (and iproute alike) is not able to identify the
> parent IEEE 802.15.4 interface of a 6LoWPAN link.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Thanks, actually I was thinking if such feature exists... That's good to
know that the slave knows about the master and can be requested on
userspace. Especially on 6LoWPAN. I tested it iproute shows
"lowpan0@wpan0" now. :-)

Acked-by: Alexander Aring <aring@mojatatu.com>

- Alex
