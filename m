Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35153 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662AbbHTQ4P (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 20 Aug 2015 12:56:15 -0400
Received: by wicne3 with SMTP id ne3so151290566wic.0
        for <linux-wpan@vger.kernel.org>; Thu, 20 Aug 2015 09:56:14 -0700 (PDT)
Date: Thu, 20 Aug 2015 18:56:07 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH] nl802154: stricter input checking for boolean inputs
Message-ID: <20150820165602.GA10675@omega>
References: <1440065387-7457-1-git-send-email-stefan@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1440065387-7457-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org

On Thu, Aug 20, 2015 at 12:09:47PM +0200, Stefan Schmidt wrote:
> So far we handled boolean input by forcing them with !! and assigning
> them into a bool. This allowed userspace to send values > 1 which were
> used as 1. We should be stricter here and return -EINVAL for all but
> 0 or 1.
> 
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>

Acked-by: Alexander Aring <alex.aring@gmail.com>

- Alex
