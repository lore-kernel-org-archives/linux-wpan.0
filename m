Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618274C8C;
	Sat, 29 Jun 2024 01:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719625146; cv=none; b=pYeoA3Hu9QzhxGLONdCPmn0iySkKg9cTA+7wecpbsEI+u/w4uwOoOINQlgC1/XV8AO6fyo68xWkQRpbM7HIqhkwjvXcvx26G3Zcj2oZyY9oOx04fksaEsacyjfrzsQC7hLQpUwBPl3JMSBccQWQgFQTjZLRcDzKQ8hfAmPeCTFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719625146; c=relaxed/simple;
	bh=54/5eeFJKqYDjuIPMCPEq3P1jJiZ4bNph2rKPD5V46A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sa0qFxl90/Y+md3d7K7q/c8Y9ZsNQG6M8hqonlfFspmC6w4ATIwv1OL6E0Nr+2CdxGdQwWCdKLkB5/N5Ab8w0LP2iXE434dcaXqShQd57gm+UUwn/3ZoEkrc3MPJUpMDVgL600oesQKBltKAQ1RMiUy7uTrwAkVrmU+OXMz1k4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8Kg2vc4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8Kg2vc4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DABEC116B1;
	Sat, 29 Jun 2024 01:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719625145;
	bh=54/5eeFJKqYDjuIPMCPEq3P1jJiZ4bNph2rKPD5V46A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S8Kg2vc49Y9HKCB64JccAl8eV0lNxYKNp3yi0uI9wG7EMdNNsydqWnXIbn2JmrJon
	 M37+nyA5R2yD+MDRvV6k5wYKlEeBHgsHRgimYqwzX9bdoRKVmQEeo4sGsRsavhVvO8
	 05H5rPOYj7HJ+gOzWd8EFnSuWHsdsJD20vSoN+NxbUOdreWXzt6NbUa+Zfs+GzF5Sy
	 LuEWZkn1YfLlV+YZxJCbFBypjkr1457COQh/4EklccXQuiWtiB4P/ox6ujkytOBUdh
	 drcz5YtIrlxE9CadOYUMgsz1Jb53wJ/2sep0pZnbjRiOGb2HXexwEpmCc9Fmoe2gzD
	 4TV7ggXloT/kA==
Date: Fri, 28 Jun 2024 18:39:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: davem@davemloft.net, pabeni@redhat.com, linux-wpan@vger.kernel.org,
 alex.aring@gmail.com, miquel.raynal@bootlin.com, netdev@vger.kernel.org
Subject: Re: pull-request: ieee802154 for net 2024-06-27
Message-ID: <20240628183904.4717d073@kernel.org>
In-Reply-To: <20240627181912.2359683-1-stefan@datenfreihafen.org>
References: <20240627181912.2359683-1-stefan@datenfreihafen.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 20:19:12 +0200 Stefan Schmidt wrote:
> Dmitry Antipov corrected the time calculations for the lifs and sifs
> periods in mac802154.
> 
> Yunshui Jiang introduced the safer use of DEV_STATS_* macros for
> atomic updates. A good addition, even if not strictly necessary in
> our code.

FTR looks like this got merged by DaveM, thank you!
