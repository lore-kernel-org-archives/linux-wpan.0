Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35781 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbbE0M2O (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 27 May 2015 08:28:14 -0400
Received: by wgme6 with SMTP id e6so8021579wgm.2
        for <linux-wpan@vger.kernel.org>; Wed, 27 May 2015 05:28:13 -0700 (PDT)
Date: Wed, 27 May 2015 14:28:11 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv2 wpan-tools] phy: convert tx power value
Message-ID: <20150527122810.GE712@omega>
References: <1432728702-3458-1-git-send-email-varkab@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1432728702-3458-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

On Wed, May 27, 2015 at 05:41:42PM +0530, Varka Bhadram wrote:
> This patch convert the tx power value from long to float to
> support the IEEE-802.15.4 radio power setting values.
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>

Thanks, applied to wpan-tools.

- Alex
