Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33821 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756836AbaISOWx (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Sep 2014 10:22:53 -0400
Received: by mail-wi0-f177.google.com with SMTP id em10so3071600wid.16
        for <linux-wpan@vger.kernel.org>; Fri, 19 Sep 2014 07:22:51 -0700 (PDT)
Date: Fri, 19 Sep 2014 16:22:49 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan raw socket problems
Message-ID: <20140919142249.GB495@omega>
References: <541C133A.7010000@xsilon.com>
 <20140919114549.GA22396@omega>
 <541C1AC2.1010308@xsilon.com>
 <20140919120630.GA23106@omega>
 <20140919123824.GA2407@omega>
 <541C2536.5080308@xsilon.com>
 <20140919125544.GA2500@omega>
 <20140919125705.GB2500@omega>
 <541C3A36.4090803@xsilon.com>
 <20140919142116.GA495@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140919142116.GA495@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, werner@almesberger.net

On Fri, Sep 19, 2014 at 04:21:16PM +0200, Alexander Aring wrote:
> On Fri, Sep 19, 2014 at 03:14:14PM +0100, Simon Vincent wrote:
> > I have implemented and tested the fix and it seems to work!
> ok.
> 
> > I used a combination of skb_unshare and pulled some of your wpan_rework
> > changes in so the compression is done in lowpan_xmit.
> > 
> 
> So you have a solution which based on current mainline. Do you like to
> rebase it on linux-wpan and send patch?
> 
and additional this fixes also doing wiresharl,tcpdump on lowpan
interfaces.

- Alex
