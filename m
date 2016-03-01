Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:52451 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752698AbcCAJR4 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 1 Mar 2016 04:17:56 -0500
Subject: Re: 802.15.4G support?
References: <CAH+RWqF-3Q8P52PTM9ZqpybEWTCKiubQK0-Y7L=c-3vAMhJfrg@mail.gmail.com>
 <20160228140659.GA17980@omega>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <56D55E41.1040905@osg.samsung.com>
Date: Tue, 1 Mar 2016 10:17:53 +0100
MIME-Version: 1.0
In-Reply-To: <20160228140659.GA17980@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Remi Philippe <remi@linqio.com>
Cc: linux-wpan@vger.kernel.org

Hello.

On 28/02/16 15:07, Alexander Aring wrote:
> Another question would be:
> You can run 6LoWPAN on it, but nobody specifies to run 6LoWPAN on such
> "SUN PHY's". I actually don't see that. Everything is specified with 127
> MTU.
>
> I don't want to tell you cannot run 6LoWPAN on it, but does somebody
> need to specify 6LoWPAN for 802.15.4g at first?
>

I would expect that for SUN phy's they would just ignore the 
fragmentation part of the spec and use all the rest of it. Still making 
use of the header compressions, subtyping, etc. Remi, please correct me 
if I'm wrong here.

regards
Stefan Schmidt

