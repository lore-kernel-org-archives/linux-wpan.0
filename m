Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35931 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbbFSHun (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Jun 2015 03:50:43 -0400
Received: by wicnd19 with SMTP id nd19so10887305wic.1
        for <linux-wpan@vger.kernel.org>; Fri, 19 Jun 2015 00:50:42 -0700 (PDT)
Date: Fri, 19 Jun 2015 09:50:39 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-tools 1/3] wpan-ping: adjust maximal packet length
 for extended addresses
Message-ID: <20150619075038.GB867@omega>
References: <1434616656-16209-1-git-send-email-stefan@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1434616656-16209-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org

On Thu, Jun 18, 2015 at 10:37:34AM +0200, Stefan Schmidt wrote:
> This value is to static right now but does its job. It needs to get
> more flexible based on various things like addressing scheme and link
> layer crypto in the future.
> 
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>

Applied all, thanks.

- Alex
