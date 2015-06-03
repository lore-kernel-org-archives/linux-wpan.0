Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37982 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbbFCPcZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 3 Jun 2015 11:32:25 -0400
Received: by wibdt2 with SMTP id dt2so17644878wib.1
        for <linux-wpan@vger.kernel.org>; Wed, 03 Jun 2015 08:32:23 -0700 (PDT)
Date: Wed, 3 Jun 2015 17:32:21 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: error: nl802154 not found
Message-ID: <20150603153218.GC744@omega>
References: <CAPpUg6Oj5TbS9qwdor-uymsU5bzhUMxJXk=RBd+1UmPXwHVK=Q@mail.gmail.com>
 <20150603144657.GB744@omega>
 <CAPpUg6Mpz+tPKeFBc6zyXo1e3O0SbQiQOWBPFNnd3cX42qS6Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPpUg6Mpz+tPKeFBc6zyXo1e3O0SbQiQOWBPFNnd3cX42qS6Pw@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Baptiste Clenet <bapclenet@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Wed, Jun 03, 2015 at 05:08:44PM +0200, Baptiste Clenet wrote:
> Linux 3.18.14
> 
> Is that a problem?
> 

yes, it was introduced in 3.19.

If you want to use the greatest 802.15.4 kernel then you need to use
bluetooth-next. For kernel version below 3.19 you need to use deprecated
lowpan-tools. [0] But this is not recommended.

- Alex

[0] https://github.com/linux-wpan/lowpan-tools
