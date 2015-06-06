Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:36462 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbbFFIZd (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 6 Jun 2015 04:25:33 -0400
Received: by wigg3 with SMTP id g3so6858201wig.1
        for <linux-wpan@vger.kernel.org>; Sat, 06 Jun 2015 01:25:32 -0700 (PDT)
Date: Sat, 6 Jun 2015 10:25:29 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-tools 0/3] wpan-ping fixes
Message-ID: <20150606082528.GC1051@omega>
References: <1433511132-15818-1-git-send-email-stefan@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1433511132-15818-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org

On Fri, Jun 05, 2015 at 03:32:09PM +0200, Stefan Schmidt wrote:
> Hello.
> 
> Some smaller fixes. wpan-ping no plays nicely in 6LoWPAN networks by settign
> the dispatch byte to not a 6LoWPAN frame. The other two are just some
> missing gitignore entries I spotted.
> 

Applied all, thanks.

- Alex
