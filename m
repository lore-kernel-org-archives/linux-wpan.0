Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36214 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbbEROAy (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 18 May 2015 10:00:54 -0400
Received: by wizk4 with SMTP id k4so80649262wiz.1
        for <linux-wpan@vger.kernel.org>; Mon, 18 May 2015 07:00:53 -0700 (PDT)
Date: Mon, 18 May 2015 16:00:47 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Kernel crash when using multiple interfaces
Message-ID: <20150518140045.GA749@omega>
References: <5555EC72.6060302@xsilon.com>
 <20150515142026.GA11157@omega>
 <55560A88.1050903@xsilon.com>
 <20150516153329.GA31491@omega>
 <5559C58F.6010607@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5559C58F.6010607@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org

Hi Simon,

On Mon, May 18, 2015 at 11:57:19AM +0100, Simon Vincent wrote:
> Hi Alex,
> 
> I can confirm your patch still results in the bad paging request.
> Maybe you are not seeing it as you have a slightly different setup.
> 
> If I understand correctly you have two virtual phys going to a single wpan
> interface
> e.g.
> phy0 -> wpan0
> phy1 -> wpan0
> 
> My setup is two separate transceivers. Each with its own phy and wpan
> interface.
> e.g.
> phy0 -> wpan0
> phy1 -> wpan1
> 

 From view of mac802154 layer this setup should be the same. Both running
two times alloc_hw and register_hw for alloc/register a wpan phy. The
driver layer is different.

With your solution to putting the worker resource on the heap then the
problem is solved?

Can you provide more information about the "bad paging request" issue? A
stacktrace or something else?

I currently have no idea why you have this issue.

- Alex
