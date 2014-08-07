Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:59141 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754383AbaHGGeL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 7 Aug 2014 02:34:11 -0400
Received: by mail-wi0-f174.google.com with SMTP id d1so10024686wiv.7
        for <linux-wpan@vger.kernel.org>; Wed, 06 Aug 2014 23:34:10 -0700 (PDT)
Date: Thu, 7 Aug 2014 08:34:05 +0200
From: Alexander Aring <alex.aring@gmail.com>
Message-ID: <20140807063400.GA17337@omega>
References: <53E2F959.6020904@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53E2F959.6020904@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: Re: wpan-next: git pull conflict
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-zigbee-devel <linux-zigbee-devel@lists.sourceforge.net>, linux-wpan@vger.kernel.org

Hi Varka,

yea I notice about that I did a force update and the github repos base
on bluetooth-next and bluetooth now.

You need to rebase your work on these repositories, sorry.

Do you have patches on top of the old repo? If not, then simple do also
a force "git reset ...".

If yes, create a branch and do git cherry-pick from the necessary
commits.

Sorry. :-(

Do you also know the new mailinglist?

http://vger.kernel.org/vger-lists.html#linux-wpan

I didn't send it to the zigbee one.


- Alex
