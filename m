Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:36634 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbbHSP64 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 19 Aug 2015 11:58:56 -0400
Received: by wicja10 with SMTP id ja10so123930809wic.1
        for <linux-wpan@vger.kernel.org>; Wed, 19 Aug 2015 08:58:55 -0700 (PDT)
Date: Wed, 19 Aug 2015 17:58:48 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-tools] mac: range checking for command accepting
 only 0 or 1
Message-ID: <20150819155843.GA3759@omega>
References: <1439993604-8335-1-git-send-email-stefan@osg.samsung.com>
 <20150819142147.GA31917@omega>
 <55D49291.6090702@osg.samsung.com>
 <20150819143331.GB31917@omega>
 <55D4A045.1040701@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55D4A045.1040701@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org

On Wed, Aug 19, 2015 at 05:27:01PM +0200, Stefan Schmidt wrote:
> The problem is with lbt and and autoreq_default which are boolean. We accept
> things like 400 just fine here and bring it down to 1.
> I'm going to fix this in nl802154 and leave it out of wpan-tools.
> 

We finally has the result that the userspace need to convert the value
then which is "unsigned long" and the netlink command requires "U8" or
"U16".

Then the command need check the range when it's U8:

0x00 - 0xff

and when it's U16:

0x0000 - 0xffff

The rest of ranges checks will do the kernel then. This will remove the
overflow in userspace e.g.

iwpan dev wpan0 set ackreq_default 256

will set the ackreq_default to 0. This check can't be done at
kernelspace side. The kernel need to check then if it's "0" or "1" only.

We need to introduce this behabiour for all U8 and U16 settings then.

- Alex
