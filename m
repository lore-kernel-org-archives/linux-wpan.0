Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:34147 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758529AbbIDJtn (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 4 Sep 2015 05:49:43 -0400
Subject: Re: [PATCH wpan-tools 0/5] Various wpan-ping fixes
References: <1441187577-12534-1-git-send-email-stefan@osg.samsung.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55E96934.4050605@osg.samsung.com>
Date: Fri, 4 Sep 2015 11:49:40 +0200
MIME-Version: 1.0
In-Reply-To: <1441187577-12534-1-git-send-email-stefan@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Hello.

On 02/09/15 11:52, Stefan Schmidt wrote:
> Hello.
>
> Nothing major. Just smaller fixes all over the place in wpan-ping. Mostly related to option
> handling.
>
> Stefan Schmidt (5):
>    wpan-ping: align wpan-ping version with the general wpan-tools version
>    wpan-ping: remove no longer used b option from getopt string
>    wpan-ping: fix usage message and mention -h option
>    wpan-ping: use correct define to fix getopt_long usage
>    wpan-ping: fix segfault for accessing invalid address
>
>   wpan-ping/wpan-ping.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
>

Pushed all of them to the repo.

regards
Stefan Schmidt
