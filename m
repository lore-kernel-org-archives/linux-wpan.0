Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37591 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbbKIUTL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 9 Nov 2015 15:19:11 -0500
Received: by wmww144 with SMTP id w144so48184330wmw.0
        for <linux-wpan@vger.kernel.org>; Mon, 09 Nov 2015 12:19:10 -0800 (PST)
Date: Mon, 9 Nov 2015 21:19:01 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-tools] build: avoid redefinition errors with libnl
 >= 3.2.27
Message-ID: <20151109201821.GA608@omega>
References: <1447092642-17115-1-git-send-email-stefan@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1447092642-17115-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On Mon, Nov 09, 2015 at 07:10:42PM +0100, Stefan Schmidt wrote:
> From 3.2.17 onwards we have nla for s8, s16, etc defined directly in libnl.
> If we keep including this file anyway we run into redefinition errors. Better
> include use our own only for earlier versions.
> 
> Happened to me on Fedora 22 after my last update.
> 
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>

Acked-by: Alexander Aring <alex.aring@gmail.com>

I wonder how could that be when I do #ifndef on each declaration. So I
was in the hope to avoid such issues....

- Alex
