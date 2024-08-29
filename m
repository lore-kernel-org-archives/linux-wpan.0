Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5427192B84;
	Thu, 29 Aug 2024 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947855; cv=none; b=IUDXwqxDi+8mG+Tj+cIcvY9bP6STPHIByajdovMMMnRiTlaTkO0M5C8uoV96WbbAyZuodfUqWY2WYezzpN25EiKvQRoq9IeBSOAnMWPJAw8ylxMA+QWci+EmmkTa2r/0DOLiKOJLSIEQJdaVE5+PnNVJQbMlF+lAocy/3VtOrh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947855; c=relaxed/simple;
	bh=VcXkFvKP0HTKubdKkm8ekUTa+0jTZLrFys1AfYKfw+Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hxyCRM9rUvbFhSDWDWjDmeGC4ykYcZxvViQjAQr+EaT1xxnPabOCrAe5Gvo6RS5vYxYD3goQCmo1X2N/YtY/z6akBBEdglZs/vZIF4qFDrQmREtpBdYvOhe+wD4zyi6OuisBcW9LSh4xV5tu/StmeTsCkgqiJn661TcmkReMl2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHoOE7tf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHoOE7tf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCEFC4CEC1;
	Thu, 29 Aug 2024 16:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724947855;
	bh=VcXkFvKP0HTKubdKkm8ekUTa+0jTZLrFys1AfYKfw+Q=;
	h=From:Subject:Date:To:Cc:From;
	b=PHoOE7tfilLOdvwAPDQytqnlFRAyXer2BSjlACXnJkEfMwPdaLq2SegAD8pYR+wzt
	 jvyvHg0L5aKH5r+DepL5BZp8GyTC9Jn79+BbWeQKhdcHFBxkXLvnDfJV8YeHOdcy+o
	 XUdP1L8laD3wQQd0s3VxG5GN3TaTXHqYQY4dr5wSzEEmZQ8kfSUycJGuyflHoqYnCI
	 mZnIEXQAv+IBFqO77gYL5N7ycAxf/IXI3HRAisuBFOL/09puSZgluMpogtcTLcK3Z+
	 +QUOpyzRJjEbOiwUYjLNikC7XbAHDqCl4XZH0gYLAvXNpBXCTQrvyTlzsYgseiT7ua
	 /R2w9XVBw9d7A==
From: Simon Horman <horms@kernel.org>
Subject: [PATCH wpan-next 0/2] wpan: Correct spelling in headers
Date: Thu, 29 Aug 2024 17:10:48 +0100
Message-Id: <20240829-wpan-spell-v1-0-799d840e02c4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIid0GYC/x2MWwqAIBAArxL7neCj7HGV6MNqq4Uw0ShBunvS5
 8DMJAjoCQP0RQKPNwU6bQZRFjDvxm7IaMkMksuKt7JjjzOWBYfHwcyktVCiFg1XkAPncaX4zwb
 4PYvxgvF9P0APAIFnAAAA
To: Alexander Aring <alex.aring@gmail.com>, 
 Stefan Schmidt <stefan@datenfreihafen.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, linux-wpan@vger.kernel.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.14.0

Correct spelling in nl802154.h and mac802154.h.
As flagged by Codespell.

---
Simon Horman (2):
      mac802154: Correct spelling in mac802154.h
      ieee802154: Correct spelling in nl802154.h

 include/net/mac802154.h | 4 ++--
 include/net/nl802154.h  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

base-commit: 9187210eee7d87eea37b45ea93454a88681894a4

