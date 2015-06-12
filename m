Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35839 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbbFLHMF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 12 Jun 2015 03:12:05 -0400
Received: by wiga1 with SMTP id a1so7974006wig.0
        for <linux-wpan@vger.kernel.org>; Fri, 12 Jun 2015 00:12:02 -0700 (PDT)
Date: Fri, 12 Jun 2015 09:11:56 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next] mac802154: cleanup llsec param flags
Message-ID: <20150612071152.GA733@omega>
References: <1434080629-8641-1-git-send-email-varkab@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1434080629-8641-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

On Fri, Jun 12, 2015 at 09:13:49AM +0530, Varka Bhadram wrote:
> This patch changes the setting of llsec param flag with the BIT macro.
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>

Acked-by: Alexander Aring <alex.aring@gmail.com>

doh, see now that I didn't started at BIT(0) in the hw and addr_filt
flags.

- Alex
