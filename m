Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from [82.165.8.211] ([82.165.8.211]:44011 "EHLO mail.holtmann.org"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753438AbcBZIMR (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 26 Feb 2016 03:12:17 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH bluetooth-next] 6lowpan: iphc: fix invalid case handling
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1456473967-26721-1-git-send-email-aar@pengutronix.de>
Date: Fri, 26 Feb 2016 00:12:14 -0800
Content-Transfer-Encoding: 7bit
Message-Id: <1838E9E0-1AC3-42D9-B553-68BBAD85E1C1@holtmann.org>
References: <1456473967-26721-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, Linux Bluetooth <linux-bluetooth@vger.kernel.org>, kernel@pengutronix.de, dan.carpenter@oracle.com

Hi Alex,

> This patch fixes the return value in a case which should never occur.
> Instead returning "-EINVAL" we return LOWPAN_IPHC_DAM_00 which is
> invalid on context based addresses. Also change the WARN_ON_ONCE to
> WARN_ONCE which was suggested by Dan Carpenter.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
> net/6lowpan/iphc.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

