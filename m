Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:64031 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932100AbaISOV1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Sep 2014 10:21:27 -0400
Received: by mail-wi0-f175.google.com with SMTP id cc10so2912769wib.2
        for <linux-wpan@vger.kernel.org>; Fri, 19 Sep 2014 07:21:25 -0700 (PDT)
Date: Fri, 19 Sep 2014 16:21:18 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan raw socket problems
Message-ID: <20140919142116.GA495@omega>
References: <20140919110854.GA21364@omega>
 <541C133A.7010000@xsilon.com>
 <20140919114549.GA22396@omega>
 <541C1AC2.1010308@xsilon.com>
 <20140919120630.GA23106@omega>
 <20140919123824.GA2407@omega>
 <541C2536.5080308@xsilon.com>
 <20140919125544.GA2500@omega>
 <20140919125705.GB2500@omega>
 <541C3A36.4090803@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <541C3A36.4090803@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, werner@almesberger.net

On Fri, Sep 19, 2014 at 03:14:14PM +0100, Simon Vincent wrote:
> I have implemented and tested the fix and it seems to work!
ok.

> I used a combination of skb_unshare and pulled some of your wpan_rework
> changes in so the compression is done in lowpan_xmit.
> 

So you have a solution which based on current mainline. Do you like to
rebase it on linux-wpan and send patch?

- Alex
