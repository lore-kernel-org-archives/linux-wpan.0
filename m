Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:35140 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbbDWJsJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Apr 2015 05:48:09 -0400
Received: by wgyo15 with SMTP id o15so12407090wgy.2
        for <linux-wpan@vger.kernel.org>; Thu, 23 Apr 2015 02:48:07 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 23 Apr 2015 11:48:07 +0200
Message-ID: <CAG9Fz+uvR29TX4-MavSqA=MPkUhsn7n0HnaDzh4PDAmrMvrsVQ@mail.gmail.com>
Subject: First kernel patch - checkpatch for at86rf230.c, false-positives?
From: Christoffer Holmstedt <christoffer.holmstedt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi
I've access to a few raspberry pi:s with the openlabs extension board
and I'm currently configuring my development environment for kernel
development to help out with the wpan subsystem.

I just ran checkpatch.pl over at86rf230.c and got 109 errors most of
them concerning macros not enclosed in parentheses. Are these
false-positives or should I add parantheses?

Regards
--
Christoffer Holmstedt
