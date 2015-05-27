Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33445 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbbE0KeL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 27 May 2015 06:34:11 -0400
Received: by pdbqa5 with SMTP id qa5so9265742pdb.0
        for <linux-wpan@vger.kernel.org>; Wed, 27 May 2015 03:34:10 -0700 (PDT)
Message-ID: <55659D8B.5070509@gmail.com>
Date: Wed, 27 May 2015 16:03:47 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH wpan-tools 2/3] info: fix tx power printout
References: <1432722305-22460-1-git-send-email-alex.aring@gmail.com> <1432722305-22460-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1432722305-22460-2-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

On 05/27/2015 03:55 PM, Alexander Aring wrote:

> This patch uses the format string "%.3g" instead "%.2g" for current
> tx power value. This is the same format string like we use to printout
> all supported tx power values.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>

Reviewed-by: Varka Bhadram <varkabhadram@gmail.com>


-- 
Varka Bhadram

