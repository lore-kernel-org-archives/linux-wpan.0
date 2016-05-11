Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37331 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074AbcEKOcl (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 11 May 2016 10:32:41 -0400
Received: by mail-wm0-f53.google.com with SMTP id a17so86333326wme.0
        for <linux-wpan@vger.kernel.org>; Wed, 11 May 2016 07:32:41 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH bluetooth-next 1/3] nl802154: move PAD to right position
References: <1462959859-6669-1-git-send-email-aar@pengutronix.de>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Message-ID: <57334285.1090606@6wind.com>
Date: Wed, 11 May 2016 16:32:37 +0200
MIME-Version: 1.0
In-Reply-To: <1462959859-6669-1-git-send-email-aar@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Le 11/05/2016 11:44, Alexander Aring a écrit :
> The PAD define should be above the experimental support. We don't care
> about if we break userspace in experimental stuff but PAD is part of the
> existing UAPI.
> 
> Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
