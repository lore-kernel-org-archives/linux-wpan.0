Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:43558 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934025AbaLLPKk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 12 Dec 2014 10:10:40 -0500
Received: by mail-wi0-f181.google.com with SMTP id r20so2861001wiv.8
        for <linux-wpan@vger.kernel.org>; Fri, 12 Dec 2014 07:10:39 -0800 (PST)
Date: Fri, 12 Dec 2014 16:10:36 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH] at86rf230: remove version check for AT86RF212
Message-ID: <20141212151033.GB28137@omega>
References: <1418339480-26681-1-git-send-email-andrey@snupi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1418339480-26681-1-git-send-email-andrey@snupi.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Andrey Yurovsky <andrey@snupi.com>
Cc: linux-wpan@vger.kernel.org, Andrey Yurovsky <yurovsky@gmail.com>

On Thu, Dec 11, 2014 at 03:11:20PM -0800, Andrey Yurovsky wrote:
> From: Andrey Yurovsky <yurovsky@gmail.com>
> 
> This version check allows the driver to only work with v1 hardware
> however there is no driver-facing difference with newer versions
> (confirmed by Atmel FAEs) so this check needlessly prevents the driver
> from being used with radios now in production.
> 
> Signed-off-by: Andrey Yurovsky <yurovsky@gmail.com>

I checked also the symbol duration and all these settings are the same
like the at86rf212 "version 1". So:

Acked-by: Alexander Aring <alex.aring@gmail.com>

- Alex
