Return-Path: <SRS0=vmy8=4V=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C2DC3F2D8
	for <linux-wpan@archiver.kernel.org>; Wed,  4 Mar 2020 12:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62EF321741
	for <linux-wpan@archiver.kernel.org>; Wed,  4 Mar 2020 12:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388060AbgCDMrq (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 4 Mar 2020 07:47:46 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:56073 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729175AbgCDMrp (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 4 Mar 2020 07:47:45 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id D47C7CECDC;
        Wed,  4 Mar 2020 13:57:10 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] MAINTAINERS: adjust to 6lowpan doc ReST conversion
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200304104717.5841-1-lukas.bulwahn@gmail.com>
Date:   Wed, 4 Mar 2020 13:47:43 +0100
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Alexander Aring <alex.aring@gmail.com>,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        linux-wpan@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <D2D045E0-180D-4F76-93D5-735A5600E62B@holtmann.org>
References: <20200304104717.5841-1-lukas.bulwahn@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Lukas,

> Commit 107db7ec7838 ("docs: networking: convert 6lowpan.txt to ReST")
> renamed 6lowpan.txt to 6lowpan.rst for the ReST conversion.
> 
> Since then, ./scripts/get_maintainer.pl --self-test complains:
> 
>  warning: no file matches F: Documentation/networking/6lowpan.txt
> 
> Adjust 6LOWPAN GENERIC (BTLE/IEEE 802.15.4) entry in MAINTAINERS.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Mauro, please ack.
> Marcel, please pick for bluetooth-next.
> 
> MAINTAINERS | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

