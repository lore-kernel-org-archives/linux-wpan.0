Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:33281 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754313AbbFWJXZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Jun 2015 05:23:25 -0400
Received: by wgck11 with SMTP id k11so4088374wgc.0
        for <linux-wpan@vger.kernel.org>; Tue, 23 Jun 2015 02:23:23 -0700 (PDT)
Date: Tue, 23 Jun 2015 11:23:14 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next] mac802154: use WARN_ON() macro
Message-ID: <20150623092311.GA761@omega>
References: <1435039863-27225-1-git-send-email-varkab@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1435039863-27225-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

On Tue, Jun 23, 2015 at 11:41:03AM +0530, Varka Bhadram wrote:
> This patch will generate the warning if the required driver ops
> were not defined. Also it removes unnecessary debug message.
> 

I don't see a debug message, I see a remove of an error message. :-)

Anyway this should printed for developing new drivers, removes some lines
of code. Comparing with 802.11 it looks the same now. So I ack it.

> Signed-off-by: Varka Bhadram <varkab@cdac.in>

Acked-by: Alexander Aring <alex.aring@gmail.com>

Thanks.

- Alex
