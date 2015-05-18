Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37029 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932468AbbERQ1c (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 18 May 2015 12:27:32 -0400
Received: by wibt6 with SMTP id t6so75895721wib.0
        for <linux-wpan@vger.kernel.org>; Mon, 18 May 2015 09:27:31 -0700 (PDT)
Date: Mon, 18 May 2015 18:27:28 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Kernel crash when using multiple interfaces
Message-ID: <20150518162727.GD749@omega>
References: <5555EC72.6060302@xsilon.com>
 <20150515142026.GA11157@omega>
 <55560A88.1050903@xsilon.com>
 <20150516153329.GA31491@omega>
 <5559C58F.6010607@xsilon.com>
 <20150518140045.GA749@omega>
 <5559FFC2.9000309@xsilon.com>
 <20150518153712.GC749@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150518153712.GC749@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org

On Mon, May 18, 2015 at 05:37:12PM +0200, Alexander Aring wrote:
> Hi,
> 
> On Mon, May 18, 2015 at 04:05:38PM +0100, Simon Vincent wrote:
> > With your patch I get either a "bad paging request" or a NULL pointer
> > dereference crash at startup. I have not had any problems with my patch.
> > 
> > Here are two stack traces I get.
> > 
> > [   12.223057] [<c04da1b8>] (ieee802154_stop_queue) from [<c04d6d64>]
> > 
> > or
> > 
> > [   12.548824] [<c04da1b8>] (ieee802154_stop_queue) from [<c04d6d64>]
> 
> Both crashes in ieee802154_stop_queue, but we don't changed anything
> which should affect the ieee802154_stop_queue in my or your fix.
>

Ah, it could be that it failed in ieee802154_tx after calling
ieee802154_stop_queue. Are you sure that you don't miss some & for
handling with pointers and then we have some invalid address?

- Alex
