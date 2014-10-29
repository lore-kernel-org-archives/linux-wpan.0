Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:38232 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbaJ2Dgn (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Oct 2014 23:36:43 -0400
Received: by mail-pa0-f48.google.com with SMTP id ey11so2227819pad.7
        for <linux-wpan@vger.kernel.org>; Tue, 28 Oct 2014 20:36:43 -0700 (PDT)
Message-ID: <5450601D.8040608@gmail.com>
Date: Wed, 29 Oct 2014 09:03:49 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 07/17] mac802154: remove might_sleep from
 driver layer
References: <1414516892-4107-1-git-send-email-alex.aring@gmail.com> <1414516892-4107-8-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414516892-4107-8-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

On 10/28/2014 10:51 PM, Alexander Aring wrote:
> This patch removes all might_sleep calls from driver layer. This
> handling is already done by mac802154 layer.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   drivers/net/ieee802154/at86rf230.c | 3 ---
>   drivers/net/ieee802154/cc2520.c    | 1 -
>   drivers/net/ieee802154/fakelb.c    | 4 ----
>   3 files changed, 8 deletions(-)
>
For CC2520 driver

Acked-by: Varka Bhadram <varkabhadram@gmail.com>

-- 
Regards,
Varka Bhadram.

